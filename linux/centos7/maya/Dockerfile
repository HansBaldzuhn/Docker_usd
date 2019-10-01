############################################################
# Dockerfile to install maya2018
# Based on nvidia/base:centos7-usd-0.8

FROM usd-docker/base:latest-centos7


##ARG current_host_ip_address
ARG usd_version
ARG maya_version
ENV USD_VERSION=usd_version

LABEL maya.version="${maya_version}.0" maintainer="Animal Logic"

ENV MAYA_LOCATION=$BUILD_DIR/maya${maya_version}DevKit

ENV MAYA_LIBRARY_DIR=$BUILD_DIR/maya${maya_version}DevKit
ENV MAYA_INCLUDE_DIR=$BUILD_DIR/maya${maya_version}DevKit/include

##ENV HTTP_HOSTNAME=$current_host_ip_address
ENV MAYA_EXECUTABLE=$MAYA_LOCATION/bin/maya
ENV MAYA_PYTHON_EXECUTABLE=$MAYA_LOCATION/bin/mayapy
ENV MAYA_MAJOR_VERSION="${maya_version}"

COPY scripts/build_maya.sh $TMP_DIR

COPY $DOWNLOADS_DIR/Maya${maya_version}_DEVKIT_Linux.tgz $DOWNLOADS_DIR/

RUN $TMP_DIR/build_maya.sh

COPY bin/maya ${MAYA_LOCATION}/bin
COPY bin/mayapy ${MAYA_LOCATION}/bin
