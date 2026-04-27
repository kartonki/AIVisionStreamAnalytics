#!/usr/bin/env bash
set -euo pipefail

export DEEPSTREAM_PATH="${DEEPSTREAM_PATH:-/opt/nvidia/deepstream/deepstream-7.1}"
export CUDA_PATH="${CUDA_PATH:-/usr/local/cuda}"

if [[ ! -d "${DEEPSTREAM_PATH}" ]]; then
  echo "WARNING: DEEPSTREAM_PATH does not exist: ${DEEPSTREAM_PATH}" >&2
fi

if [[ ! -d "${CUDA_PATH}" ]]; then
  echo "WARNING: CUDA_PATH does not exist: ${CUDA_PATH}" >&2
fi

exec "$@"
