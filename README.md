# AIVisionStreamAnalytics 

This video analytics pipeline developed in C++ on top of NVIDIA DeepStream. It enables real-time, pre-recorded processing of video streams using deep learning models, YOLO-based object detection networks. The code is implemented for scalable, high-throughput inference with efficient GPU acceleration (TritonRT - engine file), making it suitable for edge deployments and intelligent video applications. Development and testing have been performed on NVIDIA Jetson Orin Super.

This code support two pipeline.

1. Analyis live video stream
2. Analyis pre-recorded .mp4 video files 

## Live stream Pipeline

```
nvarguscamerasrc -> capsfilter -> nvstreammux -> nvinfer -> nvtracker -> nvdsanalytics -> nvvideoconvert -> nveglglessink (display sink)
```

## Pre-recorded video file

```
filesrc -> qtdemux -> h265parse -> nvv4l2decoder -> nvvideoconvert -> capsfilter -> nvstreammux -> nvinfer -> nvtracker -> nvdsanalytics -> nvvideoconvert -> fakesink (headless)
```

## Config file
- config_analytics -> Deepstream analytic config
- config_infre_primary_yolo -> Primary GIE config
- config_tracker -> tracking config

## mdls folder
- contain onnx yolov8 
- Engine file 
This folder conteint ignored for github

## Usage
``
$cd src
$bash compile.sh
``

![tracker](images/obj_tracker.gif)

- The center box defines the ROI for object counting
- Directional arrows indicate the valid movement direction—only objects moving along this path are analyzed
- A virtual line counts only those objects that cross it in the specified direction (top-to-bottom)

## Docker setup (DeepStream + build dependencies)

This repository now includes a containerized build environment with DeepStream and all compile dependencies.

### Files added

- `docker/Dockerfile` - DeepStream-based development image with compiler and GStreamer dev headers
- `docker/entrypoint.sh` - Sets `DEEPSTREAM_PATH` and `CUDA_PATH`
- `docker-compose.deepstream.yml` - Compose services for generic GPU and Jetson camera use
- `scripts/container-build.sh` - Build container image
- `scripts/container-shell.sh` - Open shell inside container
- `scripts/container-compile.sh` - Compile this project in the container

### Prerequisites on host

- Docker Engine + Docker Compose v2
- NVIDIA Container Toolkit
- Valid access to NVIDIA NGC images (`nvcr.io`)

If NGC pull fails with authorization errors, run:

```bash
docker login nvcr.io
```

### 1) Build the default DeepStream dev image

```bash
./scripts/container-build.sh
```

### 2) Open a shell in container

```bash
./scripts/container-shell.sh
```

### 3) Compile the project inside container

```bash
./scripts/container-compile.sh
```

### Jetson camera profile

For CSI camera / Argus access on Jetson, use the dedicated profile and service:

```bash
docker compose -f docker-compose.deepstream.yml --profile jetson build aivision-jetson-cam
docker compose -f docker-compose.deepstream.yml --profile jetson run --rm aivision-jetson-cam bash
```

### Optional image override

Override DeepStream base image at build time:

```bash
DEEPSTREAM_IMAGE=nvcr.io/nvidia/deepstream:7.1-triton-multiarch ./scripts/container-build.sh
DEEPSTREAM_IMAGE_JETSON=nvcr.io/nvidia/deepstream-l4t:7.1-triton-multiarch docker compose -f docker-compose.deepstream.yml --profile jetson build aivision-jetson-cam
```
