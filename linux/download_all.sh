#!/usr/bin/env bash

set -e

export DOWNLOADS_DIR="downloads"
export USD_VERSION="19.05"
export CUDA_VERSION="9.0"
export MAYA_VERSION="2019"

scripts/download_cmake.sh
scripts/download_maya.sh
scripts/download_usd.sh
scripts/download_adsk_maya-usd.sh