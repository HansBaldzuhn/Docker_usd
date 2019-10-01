#!/usr/bin/env bash
set -ex

# Build script to be run from a single RUN in Dockerfile to minimise image size
mkdir -p $TMP_DIR

#----------------------------------------------
# build and install cmake 3.11
#----------------------------------------------
cd $TMP_DIR &&\
    tar -zxf $DOWNLOADS_DIR/cmake-3.11.0.tar.gz &&\
    cd cmake-3.11.0 &&\
    ./bootstrap  \
        --prefix=$BUILD_DIR && \
     make -j ${BUILD_PROCS} && \
     make install