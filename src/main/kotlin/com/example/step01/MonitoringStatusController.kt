package com.example.step01

import com.fasterxml.jackson.databind.JsonNode
import com.fasterxml.jackson.databind.ObjectMapper
import org.springframework.beans.factory.annotation.Value
import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.RestController
import java.net.InetSocketAddress
import java.net.URI
import java.net.URLEncoder
import java.net.http.HttpClient
import java.net.http.HttpRequest
import java.net.http.HttpResponse
import java.net.Socket
import java.nio.charset.StandardCharsets
import java.time.Instant
import java.time.Duration

@RestController
class MonitoringStatusController(
    @Value("\${monitoring.grafana-health-url:http://step01-monitoring-grafana.monitoring.svc.cluster.local/login}")
    private val grafanaHealthUrl: String,
    @Value("\${monitoring.prometheus-health-url:http://step01-monitoring-kube-pro-prometheus.monitoring.svc.cluster.local:9090/-/healthy}")
    private val prometheusHealthUrl: String,
    @Value("\${monitoring.k8s-dashboard-host:kubernetes-dashboard.kubernetes-dashboard.svc.cluster.local}")
    private val kubernetesDashboardHost: String,
    @Value("\${monitoring.k8s-dashboard-port:443}")
    private val kubernetesDashboardPort: Int,
    @Value("\${monitoring.prometheus-query-url:http://step01-monitoring-kube-pro-prometheus.monitoring.svc.cluster.local:9090/api/v1/query}")
    private val prometheusQueryUrl: String,
) {
    private val objectMapper = ObjectMapper()
    private val httpClient: HttpClient = HttpClient.newBuilder()
        .connectTimeout(Duration.ofSeconds(2))
        .build()

    data class MonitoringStatusResponse(
        val grafanaUp: Boolean,
        val prometheusUp: Boolean,
        val kubernetesDashboardUp: Boolean,
        val allUp: Boolean,
    )

    data class NamespaceSnapshot(
        val namespace: String,
        val podsRunning: Int,
        val podsTotal: Int,
        val restartTotal: Int,
    )

    data class K3dMonitoringSummaryResponse(
        val nodeCount: Int,
        val step01Local: NamespaceSnapshot,
        val monitoring: NamespaceSnapshot,
        val updatedAt: String,
    )

    @GetMapping("/api/monitoring/status")
    fun status(): MonitoringStatusResponse {
        val grafanaUp = isUp(grafanaHealthUrl)
        val prometheusUp = isUp(prometheusHealthUrl)
        val kubernetesDashboardUp = isTcpPortOpen(kubernetesDashboardHost, kubernetesDashboardPort)
        return MonitoringStatusResponse(
            grafanaUp = grafanaUp,
            prometheusUp = prometheusUp,
            kubernetesDashboardUp = kubernetesDashboardUp,
            allUp = grafanaUp && prometheusUp && kubernetesDashboardUp,
        )
    }

    @GetMapping("/api/monitoring/k3d-summary")
    fun k3dSummary(): K3dMonitoringSummaryResponse {
        val nodeCount = queryScalar("count(kube_node_info)")
        val step01Local = namespaceSnapshot("step01-local")
        val monitoring = namespaceSnapshot("monitoring")
        return K3dMonitoringSummaryResponse(
            nodeCount = nodeCount.toInt(),
            step01Local = step01Local,
            monitoring = monitoring,
            updatedAt = Instant.now().toString(),
        )
    }

    private fun isUp(url: String): Boolean {
        return try {
            val request = HttpRequest.newBuilder()
                .uri(URI.create(url))
                .GET()
                .timeout(Duration.ofSeconds(3))
                .build()
            val response = httpClient.send(request, HttpResponse.BodyHandlers.discarding())
            response.statusCode() in 200..399
        } catch (_: Exception) {
            false
        }
    }

    private fun isTcpPortOpen(host: String, port: Int): Boolean {
        return try {
            Socket().use { socket ->
                socket.connect(InetSocketAddress(host, port), 2000)
                true
            }
        } catch (_: Exception) {
            false
        }
    }

    private fun namespaceSnapshot(namespace: String): NamespaceSnapshot {
        val podsRunning = queryScalar("count(kube_pod_status_phase{namespace=\"$namespace\",phase=\"Running\"} == 1)")
        val podsTotal = queryScalar("count(kube_pod_info{namespace=\"$namespace\"})")
        val restartTotal = queryScalar("sum(kube_pod_container_status_restarts_total{namespace=\"$namespace\"})")
        return NamespaceSnapshot(
            namespace = namespace,
            podsRunning = podsRunning.toInt(),
            podsTotal = podsTotal.toInt(),
            restartTotal = restartTotal.toInt(),
        )
    }

    private fun queryScalar(promql: String): Double {
        return try {
            val encoded = URLEncoder.encode(promql, StandardCharsets.UTF_8)
            val request = HttpRequest.newBuilder()
                .uri(URI.create("$prometheusQueryUrl?query=$encoded"))
                .GET()
                .timeout(Duration.ofSeconds(4))
                .build()
            val response = httpClient.send(request, HttpResponse.BodyHandlers.ofString())
            if (response.statusCode() !in 200..299) {
                return 0.0
            }

            val root: JsonNode = objectMapper.readTree(response.body())
            val valueNode = root.path("data").path("result")
            if (!valueNode.isArray || valueNode.isEmpty) {
                return 0.0
            }
            valueNode[0].path("value").get(1)?.asText()?.toDoubleOrNull() ?: 0.0
        } catch (_: Exception) {
            0.0
        }
    }
}
