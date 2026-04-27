#!/usr/bin/env bash
set -euo pipefail

COMPOSE_FILE="docker-compose.deepstream.yml"
SERVICE="${1:-aivision-dev}"

docker compose -f "${COMPOSE_FILE}" build "${SERVICE}"
