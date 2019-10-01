############################################################
# Dockerfile to build USD Maya
     
FROM usd-docker/maya:latest-centos7

ARG usd_version
ARG maya_version

LABEL pxr.usd.version="$usd_version" maintainer="Hans Baldzuhn - hans.baldzuhn@gmail.com"

ENV USD_VERSION=$usd_version
ENV MAYA_VERSION=$maya_version

COPY $DOWNLOADS_DIR/USD-v${USD_VERSION}.tar.gz $DOWNLOADS_DIR/

ENV USD_BUILD_DIR=$BUILD_DIR/usd/${USD_VERSION}
RUN mkdir -p ${USD_BUILD_DIR}
   
RUN cd $TMP_DIR && \
	tar -zxf $DOWNLOADS_DIR/USD-v${USD_VERSION}.tar.gz && \
	cd USD-${USD_VERSION} &&\
	mkdir -p build && cd build && \
	python ../build_scripts/build_usd.py -vvv \
#	--build-monolithic \
#	--tests \
	--build-args \
	boost,"--with-date_time --with-thread --with-system --with-filesystem" \
    --no-maya \
    --materialx \
#	--maya \	
#	--maya-location ${MAYA_LOCATION} \
	${USD_BUILD_DIR}


ENV USD_INSTALL_ROOT=${USD_BUILD_DIR}
ENV USD_CONFIG_FILE=$USD_INSTALL_ROOT/pxrConfig.cmake
ENV PATH=$PATH:$USD_INSTALL_ROOT/bin
ENV LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$USD_INSTALL_ROOT/lib
ENV PYTHONPATH=$PYTHONPATH:$USD_INSTALL_ROOT/lib/python
