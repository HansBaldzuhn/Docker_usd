############################################################
# Dockerfile to install maya2018
# Based on nvidia/base:centos7-usd-0.8

FROM usd-docker/pixar-usd:latest-centos7

##ARG current_host_ip_address
ARG usd_version
ARG maya_version
ENV USD_VERSION=${usd_version}

LABEL maya.version="${maya_version}.0" maintainer="Animal Logic"

ENV MAYA_LOCATION=$BUILD_DIR/maya${maya_version}DevKit

ENV MAYA_LIBRARY_DIR=$BUILD_DIR/maya${maya_version}DevKit
ENV MAYA_INCLUDE_DIR=$BUILD_DIR/maya${maya_version}DevKit/include

ENV MAYA_EXECUTABLE=$MAYA_LOCATION/bin/maya
ENV MAYA_PYTHON_EXECUTABLE=$MAYA_LOCATION/bin/mayapy
ENV MAYA_MAJOR_VERSION="${maya_version}"

COPY $DOWNLOADS_DIR/maya-usd-master.zip $DOWNLOADS_DIR
COPY $DOWNLOADS_DIR/ninja-v1.9.0.tar.gz $DOWNLOADS_DIR


#########################
## BUILD autodesk usd plugin

ENV USD_MAYA_BUILD_DIR=${BUILD_DIR}/maya_usd/maya${maya_version}_usd${USD_VERSION}
ENV USD_MAYA_INSTALL_DIR=${USD_MAYA_BUILD_DIR}/install


RUN mkdir -p ${USD_MAYA_BUILD_DIR} && \
    mkdir -p ${USD_MAYA_INSTALL_DIR} 

ENV USD_LIBRARY=${USD_BUILD_DIR}/lib:${USD_BUILD_DIR}/build/USD-${USD_VERSION}/pxr/base/lib/
ENV USD_LIBRARY_ROOT=${USD_BUILD_DIR}/build/USD-${USD_VERSION}


#########################
# Install Ninja Generator
RUN cd $TMP_DIR && \
	tar -zxf $DOWNLOADS_DIR/ninja-v1.9.0.tar.gz && \
	cd ninja-1.9.0 && \
    ./configure.py --bootstrap
    
ENV NINJA=$TMP_DIR/ninja-1.9.0/ninja
    
RUN unzip $DOWNLOADS_DIR/maya-usd-master.zip -d $TMP_DIR
    
RUN cd $TMP_DIR/maya-usd-master && \
	python build.py \
	-v 3 \
	--generator Ninja \
    --build-args="-DCMAKE_MAKE_PROGRAM=${NINJA}" \
    --maya-location ${MAYA_LOCATION} \
    --devkit-location ${MAYA_LOCATION}  \
    --pxrusd-location ${USD_BUILD_DIR} \
    --install-location ${USD_MAYA_INSTALL_DIR} \
    ${USD_MAYA_BUILD_DIR}
    

ENV USD_INSTALL_ROOT=${USD_BUILD_DIR}
ENV USD_CONFIG_FILE=$USD_INSTALL_ROOT/pxrConfig.cmake
ENV PATH=$PATH:$USD_INSTALL_ROOT/bin
ENV LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$USD_INSTALL_ROOT/lib
ENV PYTHONPATH=$PYTHONPATH:$USD_INSTALL_ROOT/lib/python