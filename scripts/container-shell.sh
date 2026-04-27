#!/usr/bin/env bash
set -euo pipefail

readonly COMPOSE_FILE="docker-compose.deepstream.yml"
readonly SERVICE="${1:-aivision-dev}"

docker compose -f "${COMPOSE_FILE}" run --rm "${SERVICE}" bash
