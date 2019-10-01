############################################################
# Dockerfile to install maya2018
# Based on nvidia/base:centos7-usd-0.8

FROM usd-docker/vfx:latest-centos7


ARG usd_version
ARG maya_version
ENV USD_VERSION=usd_version

LABEL maya.version="${maya_version}.0" maintainer="Animal Logic"

ENV MAYA_LOCATION=$BUILD_DIR/maya${maya_version}DevKit

ENV MAYA_LIBRARY_DIR=$BUILD_DIR/maya${maya_version}DevKit
ENV MAYA_INCLUDE_DIR=$BUILD_DIR/maya${maya_version}DevKit/include

ENV MAYA_EXECUTABLE=$MAYA_LOCATION/bin/maya
ENV MAYA_PYTHON_EXECUTABLE=$MAYA_LOCATION/bin/mayapy
ENV MAYA_MAJOR_VERSION="${maya_version}"

COPY downloads/Maya2019_DEVKIT_Linux.tgz $DOWNLOADS_DIR/
#COPY downloads/maya-usd-master.zip $DOWNLOADS_DIR/

COPY scripts/build_maya.sh /tmp/

RUN  /tmp/build_maya.sh
COPY bin/maya ${MAYA_LOCATION}/bin
COPY bin/mayapy ${MAYA_LOCATION}/bin