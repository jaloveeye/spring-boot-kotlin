#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
ENV_FILE="${ROOT_DIR}/deploy/.env.local-deploy"
EXAMPLE_ENV_FILE="${ROOT_DIR}/deploy/.env.local-deploy.example"
COMPOSE_FILE="${ROOT_DIR}/deploy/compose.local.yml"

usage() {
  cat <<'EOF'
Usage:
  bash scripts/local-deploy.sh up
  bash scripts/local-deploy.sh down
  bash scripts/local-deploy.sh rebuild
  bash scripts/local-deploy.sh logs
  bash scripts/local-deploy.sh status
EOF
}

ensure_env_file() {
  if [[ ! -f "${ENV_FILE}" ]]; then
    cp "${EXAMPLE_ENV_FILE}" "${ENV_FILE}"
    echo "Created ${ENV_FILE} from example. Adjust values if needed and rerun."
    exit 0
  fi
}

compose() {
  docker compose --env-file "${ENV_FILE}" -f "${COMPOSE_FILE}" "$@"
}

build_image() {
  APP_IMAGE_VALUE="$(grep '^APP_IMAGE=' "${ENV_FILE}" | cut -d'=' -f2-)"
  docker build -t "${APP_IMAGE_VALUE}" "${ROOT_DIR}"
}

case "${1:-}" in
  up)
    ensure_env_file
    build_image
    compose up -d
    ;;
  rebuild)
    ensure_env_file
    build_image
    compose up -d --force-recreate
    ;;
  down)
    ensure_env_file
    compose down
    ;;
  logs)
    ensure_env_file
    compose logs -f
    ;;
  status)
    ensure_env_file
    compose ps
    ;;
  *)
    usage
    exit 1
    ;;
esac
