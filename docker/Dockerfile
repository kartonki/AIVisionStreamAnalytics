# syntax=docker/dockerfile:1.6

ARG DEEPSTREAM_IMAGE=nvcr.io/nvidia/deepstream:7.1-triton-multiarch
FROM ${DEEPSTREAM_IMAGE}

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    pkg-config \
    libgstreamer1.0-dev \
    libglib2.0-dev \
    gstreamer1.0-tools \
    gstreamer1.0-plugins-base \
    gstreamer1.0-plugins-good \
    ca-certificates \
    git \
    && rm -rf /var/lib/apt/lists/*

ENV DEEPSTREAM_PATH=/opt/nvidia/deepstream/deepstream-7.1
ENV CUDA_PATH=/usr/local/cuda

WORKDIR /workspace/AIVisionStreamAnalytics

COPY docker/entrypoint.sh /usr/local/bin/aivision-entrypoint.sh
RUN chmod +x /usr/local/bin/aivision-entrypoint.sh

ENTRYPOINT ["/usr/local/bin/aivision-entrypoint.sh"]
CMD ["bash"]
