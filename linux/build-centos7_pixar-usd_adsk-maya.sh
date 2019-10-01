#!/usr/bin/env bash

set -e

export DOWNLOADS_DIR="downloads"
export USD_VERSION="19.05"
export CUDA_VERSION="9.0"
export MAYA_VERSION="2019"


echo "Build base: base centos packages and gcc"
scripts/download_cmake.sh
docker build --build-arg cuda_version=${CUDA_VERSION} \
             -t "usd-docker/base:1-centos7" \
             -f centos7/base/Dockerfile .
docker tag "usd-docker/base:1-centos7" "usd-docker/base:latest-centos7"


echo "Build Maya v${MAYA_VERSION}"
scripts/download_maya.sh
docker build --build-arg maya_version=${MAYA_VERSION} \
             -t "usd-docker/maya${MAYA_VERSION}_adsk:1-centos7" \
             -f centos7/maya/Dockerfile .
docker tag "usd-docker/maya${MAYA_VERSION}:1-centos7" "usd-docker/maya:latest-centos7"


echo "Build USD v${USD_VERSION}"
scripts/download_usd.sh
docker build --build-arg usd_version=${USD_VERSION} \
			 --build-arg maya_version=${MAYA_VERSION} \
             -t "usd-docker/pixar-usd:${USD_VERSION}-centos7" \
             -f centos7/pixar_usd/Dockerfile .
docker tag "usd-docker/pixar-usd:${USD_VERSION}-centos7" "usd-docker/pixar-usd:latest-centos7"


echo "Build maya-usd plugin from autodesk"
scripts/download_maya_usd.sh
docker build --build-arg usd_version=${USD_VERSION} \
			 --build-arg maya_version=${MAYA_VERSION} \
             -t "usd-docker/adsk_maya-usd_${MAYA_VERSION}:${USD_VERSION}-centos7" \
             -f centos7/autodesk/Dockerfile .
docker tag "usd-docker/adsk_maya-usd_${MAYA_VERSION}:${USD_VERSION}-centos7" "usd-docker/adsk_maya-usd:latest-centos7"

