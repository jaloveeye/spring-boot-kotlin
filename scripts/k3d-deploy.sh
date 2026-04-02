#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
K3D_BIN="${K3D_BIN:-$HOME/.local/bin/k3d}"
KUBECTL_BIN="${KUBECTL_BIN:-$HOME/.local/bin/kubectl}"

CLUSTER_NAME="${CLUSTER_NAME:-step01}"
NAMESPACE="${NAMESPACE:-step01-local}"
APP_IMAGE="${APP_IMAGE:-step01:local}"
MANIFEST_FILE="${ROOT_DIR}/deploy/k8s/k3d/step01-local.yaml"
HOST_PORT="${HOST_PORT:-18082}"
HOST_GRAFANA_PORT="${HOST_GRAFANA_PORT:-3000}"
HOST_PROMETHEUS_PORT="${HOST_PROMETHEUS_PORT:-9090}"

usage() {
  cat <<'EOF'
Usage:
  bash scripts/k3d-deploy.sh up
  bash scripts/k3d-deploy.sh rebuild
  bash scripts/k3d-deploy.sh down
  bash scripts/k3d-deploy.sh status
  bash scripts/k3d-deploy.sh logs

Default endpoint:
  http://localhost:18082
EOF
}

require_bin() {
  local bin_path="$1"
  if [[ ! -x "${bin_path}" ]]; then
    echo "Missing executable: ${bin_path}"
    exit 1
  fi
}

cluster_exists() {
  "${K3D_BIN}" cluster get "${CLUSTER_NAME}" >/dev/null 2>&1
}

create_cluster() {
  if cluster_exists; then
    return 0
  fi

  "${K3D_BIN}" cluster create "${CLUSTER_NAME}" \
    --servers 1 \
    --agents 1 \
    --wait \
    --port "${HOST_PORT}:30080@loadbalancer" \
    --port "${HOST_GRAFANA_PORT}:32000@loadbalancer" \
    --port "${HOST_PROMETHEUS_PORT}:32090@loadbalancer"
}

build_image() {
  docker build -t "${APP_IMAGE}" "${ROOT_DIR}"
}

deploy() {
  "${K3D_BIN}" image import "${APP_IMAGE}" -c "${CLUSTER_NAME}"
  "${KUBECTL_BIN}" apply -f "${MANIFEST_FILE}"
  "${KUBECTL_BIN}" -n "${NAMESPACE}" rollout status deployment/step01-postgres --timeout=180s
  # Reusing a mutable local tag means we need an explicit restart to pick up the new image.
  "${KUBECTL_BIN}" -n "${NAMESPACE}" rollout restart deployment/step01-app
  "${KUBECTL_BIN}" -n "${NAMESPACE}" rollout status deployment/step01-app --timeout=180s
}

case "${1:-}" in
  up)
    require_bin "${K3D_BIN}"
    require_bin "${KUBECTL_BIN}"
    create_cluster
    build_image
    deploy
    ;;
  rebuild)
    require_bin "${K3D_BIN}"
    require_bin "${KUBECTL_BIN}"
    create_cluster
    build_image
    deploy
    ;;
  down)
    require_bin "${K3D_BIN}"
    if cluster_exists; then
      "${K3D_BIN}" cluster delete "${CLUSTER_NAME}"
    else
      echo "Cluster '${CLUSTER_NAME}' does not exist."
    fi
    ;;
  status)
    require_bin "${K3D_BIN}"
    require_bin "${KUBECTL_BIN}"
    "${K3D_BIN}" cluster list
    echo
    "${KUBECTL_BIN}" get pods -n "${NAMESPACE}" -o wide 2>/dev/null || true
    echo
    "${KUBECTL_BIN}" get svc -n "${NAMESPACE}" 2>/dev/null || true
    ;;
  logs)
    require_bin "${KUBECTL_BIN}"
    "${KUBECTL_BIN}" -n "${NAMESPACE}" logs deploy/step01-app -f
    ;;
  *)
    usage
    exit 1
    ;;
esac
