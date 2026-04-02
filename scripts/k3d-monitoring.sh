#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
K3D_BIN="${K3D_BIN:-$HOME/.local/bin/k3d}"
KUBECTL_BIN="${KUBECTL_BIN:-$HOME/.local/bin/kubectl}"
HELM_BIN="${HELM_BIN:-$HOME/.local/bin/helm}"

CLUSTER_NAME="${CLUSTER_NAME:-step01}"
NAMESPACE="${NAMESPACE:-monitoring}"
RELEASE="${RELEASE:-step01-monitoring}"
CHART="${CHART:-prometheus-community/kube-prometheus-stack}"
VALUES_FILE="${ROOT_DIR}/deploy/k8s/monitoring/kube-prometheus-stack.values.yaml"
OBSERVABILITY_FILE="${ROOT_DIR}/deploy/k8s/monitoring/step01-observability.yaml"
K8S_DASHBOARD_RBAC_FILE="${ROOT_DIR}/deploy/k8s/monitoring/kubernetes-dashboard-rbac.yaml"
RUNTIME_DIR="${RUNTIME_DIR:-/tmp/step01-monitoring}"
GRAFANA_PID_FILE="${RUNTIME_DIR}/grafana-portforward.pid"
PROMETHEUS_PID_FILE="${RUNTIME_DIR}/prometheus-portforward.pid"
K8S_PROXY_PID_FILE="${RUNTIME_DIR}/k8s-dashboard-proxy.pid"
DASHBOARD_NAMESPACE="${DASHBOARD_NAMESPACE:-kubernetes-dashboard}"
DASHBOARD_PROXY_PORT="${DASHBOARD_PROXY_PORT:-8001}"
DASHBOARD_MANIFEST_URL="${DASHBOARD_MANIFEST_URL:-https://raw.githubusercontent.com/kubernetes/dashboard/v2.7.0/aio/deploy/recommended.yaml}"
AUTO_START_DASHBOARD="${AUTO_START_DASHBOARD:-true}"
DASHBOARD_TOKEN_FILE="${RUNTIME_DIR}/dashboard.token"

usage() {
  cat <<'EOF'
Usage:
  bash scripts/k3d-monitoring.sh up
  bash scripts/k3d-monitoring.sh down
  bash scripts/k3d-monitoring.sh status
  bash scripts/k3d-monitoring.sh password
  bash scripts/k3d-monitoring.sh grafana
  bash scripts/k3d-monitoring.sh grafana-bg
  bash scripts/k3d-monitoring.sh grafana-stop
  bash scripts/k3d-monitoring.sh prometheus
  bash scripts/k3d-monitoring.sh prometheus-bg
  bash scripts/k3d-monitoring.sh prometheus-stop
  bash scripts/k3d-monitoring.sh dashboard-up
  bash scripts/k3d-monitoring.sh dashboard-down
  bash scripts/k3d-monitoring.sh dashboard-token
  bash scripts/k3d-monitoring.sh dashboard-token-save
  bash scripts/k3d-monitoring.sh dashboard
  bash scripts/k3d-monitoring.sh dashboard-bg
  bash scripts/k3d-monitoring.sh dashboard-stop

Port-forward shortcuts:
  grafana    -> http://localhost:3000
  prometheus -> http://localhost:9090
  dashboard  -> http://localhost:8001/.../proxy/

Direct URLs (k3d port mapping):
  grafana    -> http://localhost:3000
  prometheus -> http://localhost:9090
  dashboard  -> http://localhost:8001/api/v1/namespaces/kubernetes-dashboard/services/https:kubernetes-dashboard:/proxy/

Env:
  AUTO_START_DASHBOARD=true|false  (default: true)
EOF
}

require_bin() {
  local bin_path="$1"
  if [[ ! -x "${bin_path}" ]]; then
    echo "Missing executable: ${bin_path}"
    exit 1
  fi
}

ensure_cluster() {
  if ! "${K3D_BIN}" cluster get "${CLUSTER_NAME}" >/dev/null 2>&1; then
    echo "Cluster '${CLUSTER_NAME}' not found. Run: bash scripts/k3d-deploy.sh up"
    exit 1
  fi
}

start_pf_bg() {
  local svc="$1"
  local local_port="$2"
  local remote_port="$3"
  local pid_file="$4"
  local log_file="$5"

  mkdir -p "${RUNTIME_DIR}"

  if [[ -f "${pid_file}" ]] && kill -0 "$(cat "${pid_file}")" 2>/dev/null; then
    echo "Port-forward already running (pid=$(cat "${pid_file}"))"
    return 0
  fi

  nohup "${KUBECTL_BIN}" -n "${NAMESPACE}" port-forward "svc/${svc}" "${local_port}:${remote_port}" \
    >"${log_file}" 2>&1 &
  echo $! >"${pid_file}"
  sleep 1

  if kill -0 "$(cat "${pid_file}")" 2>/dev/null; then
    echo "Started port-forward in background (pid=$(cat "${pid_file}"))"
    echo "URL: http://localhost:${local_port}"
  else
    echo "Failed to start port-forward. See log: ${log_file}"
    exit 1
  fi
}

stop_pf_bg() {
  local pid_file="$1"
  local name="$2"

  if [[ ! -f "${pid_file}" ]]; then
    echo "${name} port-forward is not running."
    return 0
  fi

  local pid
  pid="$(cat "${pid_file}")"
  if kill -0 "${pid}" 2>/dev/null; then
    kill "${pid}" || true
  fi
  rm -f "${pid_file}"
  echo "Stopped ${name} port-forward."
}

start_k8s_proxy_bg() {
  mkdir -p "${RUNTIME_DIR}"

  if [[ -f "${K8S_PROXY_PID_FILE}" ]] && kill -0 "$(cat "${K8S_PROXY_PID_FILE}")" 2>/dev/null; then
    echo "dashboard proxy already running (pid=$(cat "${K8S_PROXY_PID_FILE}"))"
    return 0
  fi

  nohup "${KUBECTL_BIN}" proxy --port="${DASHBOARD_PROXY_PORT}" \
    --address=0.0.0.0 \
    --accept-hosts='^.*$' \
    >"${RUNTIME_DIR}/k8s-dashboard-proxy.log" 2>&1 &
  echo $! >"${K8S_PROXY_PID_FILE}"
  sleep 1

  if kill -0 "$(cat "${K8S_PROXY_PID_FILE}")" 2>/dev/null; then
    echo "Started Kubernetes API proxy in background (pid=$(cat "${K8S_PROXY_PID_FILE}"))"
    echo "Dashboard URL: http://localhost:${DASHBOARD_PROXY_PORT}/api/v1/namespaces/${DASHBOARD_NAMESPACE}/services/https:kubernetes-dashboard:/proxy/"
  else
    echo "Failed to start Kubernetes API proxy. See log: ${RUNTIME_DIR}/k8s-dashboard-proxy.log"
    exit 1
  fi
}

stop_k8s_proxy_bg() {
  if [[ ! -f "${K8S_PROXY_PID_FILE}" ]]; then
    echo "dashboard proxy is not running."
    return 0
  fi

  local pid
  pid="$(cat "${K8S_PROXY_PID_FILE}")"
  if kill -0 "${pid}" 2>/dev/null; then
    kill "${pid}" || true
  fi
  rm -f "${K8S_PROXY_PID_FILE}"
  echo "Stopped dashboard proxy."
}

case "${1:-}" in
  up)
    require_bin "${K3D_BIN}"
    require_bin "${KUBECTL_BIN}"
    require_bin "${HELM_BIN}"
    ensure_cluster
    "${HELM_BIN}" repo add prometheus-community https://prometheus-community.github.io/helm-charts >/dev/null 2>&1 || true
    "${HELM_BIN}" repo update
    "${HELM_BIN}" upgrade --install "${RELEASE}" "${CHART}" \
      --namespace "${NAMESPACE}" \
      --create-namespace \
      -f "${VALUES_FILE}"
    "${KUBECTL_BIN}" apply -f "${OBSERVABILITY_FILE}"
    while read -r deploy_name; do
      "${KUBECTL_BIN}" -n "${NAMESPACE}" rollout status "${deploy_name}" --timeout=300s
    done < <("${KUBECTL_BIN}" -n "${NAMESPACE}" get deploy -l "app.kubernetes.io/instance=${RELEASE}" -o name)
    "${KUBECTL_BIN}" -n "${NAMESPACE}" wait \
      --for=condition=Ready pod \
      -l "app.kubernetes.io/instance=${RELEASE}" \
      --timeout=300s
    if [[ "${AUTO_START_DASHBOARD}" == "true" ]]; then
      "${KUBECTL_BIN}" apply -f "${DASHBOARD_MANIFEST_URL}"
      "${KUBECTL_BIN}" apply -f "${K8S_DASHBOARD_RBAC_FILE}"
      "${KUBECTL_BIN}" -n "${DASHBOARD_NAMESPACE}" rollout status deploy/kubernetes-dashboard --timeout=300s
      "${KUBECTL_BIN}" -n "${DASHBOARD_NAMESPACE}" rollout status deploy/dashboard-metrics-scraper --timeout=300s
      start_k8s_proxy_bg
    fi
    echo "Grafana URL: http://localhost:3000"
    echo "Prometheus URL: http://localhost:9090"
    echo "K8s Dashboard URL: http://localhost:${DASHBOARD_PROXY_PORT}/api/v1/namespaces/${DASHBOARD_NAMESPACE}/services/https:kubernetes-dashboard:/proxy/"
    ;;
  dashboard-up)
    require_bin "${K3D_BIN}"
    require_bin "${KUBECTL_BIN}"
    ensure_cluster
    "${KUBECTL_BIN}" apply -f "${DASHBOARD_MANIFEST_URL}"
    "${KUBECTL_BIN}" apply -f "${K8S_DASHBOARD_RBAC_FILE}"
    "${KUBECTL_BIN}" -n "${DASHBOARD_NAMESPACE}" rollout status deploy/kubernetes-dashboard --timeout=300s
    "${KUBECTL_BIN}" -n "${DASHBOARD_NAMESPACE}" rollout status deploy/dashboard-metrics-scraper --timeout=300s
    echo "Dashboard installed."
    echo "Run proxy: bash scripts/k3d-monitoring.sh dashboard-bg"
    ;;
  dashboard-down)
    require_bin "${KUBECTL_BIN}"
    "${KUBECTL_BIN}" delete -f "${DASHBOARD_MANIFEST_URL}" || true
    "${KUBECTL_BIN}" -n "${DASHBOARD_NAMESPACE}" delete -f "${K8S_DASHBOARD_RBAC_FILE}" || true
    stop_k8s_proxy_bg
    ;;
  dashboard-token)
    require_bin "${KUBECTL_BIN}"
    "${KUBECTL_BIN}" -n "${DASHBOARD_NAMESPACE}" create token admin-user
    ;;
  dashboard-token-save)
    require_bin "${KUBECTL_BIN}"
    mkdir -p "${RUNTIME_DIR}"
    "${KUBECTL_BIN}" -n "${DASHBOARD_NAMESPACE}" create token admin-user > "${DASHBOARD_TOKEN_FILE}"
    chmod 600 "${DASHBOARD_TOKEN_FILE}"
    echo "Saved token: ${DASHBOARD_TOKEN_FILE}"
    ;;
  dashboard)
    require_bin "${KUBECTL_BIN}"
    echo "Starting Kubernetes API proxy on http://localhost:${DASHBOARD_PROXY_PORT}"
    echo "Dashboard URL: http://localhost:${DASHBOARD_PROXY_PORT}/api/v1/namespaces/${DASHBOARD_NAMESPACE}/services/https:kubernetes-dashboard:/proxy/"
    "${KUBECTL_BIN}" proxy --port="${DASHBOARD_PROXY_PORT}" --address=0.0.0.0 --accept-hosts='^.*$'
    ;;
  dashboard-bg)
    require_bin "${KUBECTL_BIN}"
    start_k8s_proxy_bg
    ;;
  dashboard-stop)
    stop_k8s_proxy_bg
    ;;
  down)
    require_bin "${HELM_BIN}"
    "${HELM_BIN}" -n "${NAMESPACE}" uninstall "${RELEASE}" || true
    stop_pf_bg "${GRAFANA_PID_FILE}" "grafana"
    stop_pf_bg "${PROMETHEUS_PID_FILE}" "prometheus"
    stop_k8s_proxy_bg
    ;;
  status)
    require_bin "${HELM_BIN}"
    require_bin "${KUBECTL_BIN}"
    "${HELM_BIN}" list -n "${NAMESPACE}" || true
    echo
    "${KUBECTL_BIN}" get pods -n "${NAMESPACE}" -o wide || true
    echo
    "${KUBECTL_BIN}" get svc -n "${NAMESPACE}" || true
    echo
    "${KUBECTL_BIN}" get pods -n "${DASHBOARD_NAMESPACE}" -o wide 2>/dev/null || true
    echo
    "${KUBECTL_BIN}" get svc -n "${DASHBOARD_NAMESPACE}" 2>/dev/null || true
    echo
    if [[ -f "${GRAFANA_PID_FILE}" ]] && kill -0 "$(cat "${GRAFANA_PID_FILE}")" 2>/dev/null; then
      echo "grafana port-forward: running (pid=$(cat "${GRAFANA_PID_FILE}"), url=http://localhost:3000)"
    else
      echo "grafana port-forward: not running"
    fi
    if [[ -f "${PROMETHEUS_PID_FILE}" ]] && kill -0 "$(cat "${PROMETHEUS_PID_FILE}")" 2>/dev/null; then
      echo "prometheus port-forward: running (pid=$(cat "${PROMETHEUS_PID_FILE}"), url=http://localhost:9090)"
    else
      echo "prometheus port-forward: not running"
    fi
    if [[ -f "${K8S_PROXY_PID_FILE}" ]] && kill -0 "$(cat "${K8S_PROXY_PID_FILE}")" 2>/dev/null; then
      echo "dashboard proxy: running (pid=$(cat "${K8S_PROXY_PID_FILE}"), url=http://localhost:${DASHBOARD_PROXY_PORT}/api/v1/namespaces/${DASHBOARD_NAMESPACE}/services/https:kubernetes-dashboard:/proxy/)"
    else
      echo "dashboard proxy: not running"
    fi
    ;;
  password)
    require_bin "${KUBECTL_BIN}"
    "${KUBECTL_BIN}" -n "${NAMESPACE}" get secret "${RELEASE}"-grafana \
      -o jsonpath="{.data.admin-password}" | base64 -d
    echo
    ;;
  grafana)
    require_bin "${KUBECTL_BIN}"
    echo "Starting port-forward: http://localhost:3000 -> ${RELEASE}-grafana:80"
    "${KUBECTL_BIN}" -n "${NAMESPACE}" port-forward svc/"${RELEASE}"-grafana 3000:80
    ;;
  grafana-bg)
    require_bin "${KUBECTL_BIN}"
    start_pf_bg "${RELEASE}-grafana" 3000 80 "${GRAFANA_PID_FILE}" "${RUNTIME_DIR}/grafana-portforward.log"
    ;;
  grafana-stop)
    stop_pf_bg "${GRAFANA_PID_FILE}" "grafana"
    ;;
  prometheus)
    require_bin "${KUBECTL_BIN}"
    echo "Starting port-forward: http://localhost:9090 -> ${RELEASE}-kube-pro-prometheus:9090"
    "${KUBECTL_BIN}" -n "${NAMESPACE}" port-forward svc/"${RELEASE}"-kube-pro-prometheus 9090:9090
    ;;
  prometheus-bg)
    require_bin "${KUBECTL_BIN}"
    start_pf_bg "${RELEASE}-kube-pro-prometheus" 9090 9090 "${PROMETHEUS_PID_FILE}" "${RUNTIME_DIR}/prometheus-portforward.log"
    ;;
  prometheus-stop)
    stop_pf_bg "${PROMETHEUS_PID_FILE}" "prometheus"
    ;;
  *)
    usage
    exit 1
    ;;
esac
