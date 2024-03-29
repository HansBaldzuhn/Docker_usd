#!/usr/bin/env bash
set -e

mkdir -p $TMP_DIR

mkdir -p $MAYA_LOCATION
mkdir -p $MAYA_LOCATION/bin

#----------------------------------------------
# Install Maya DevKit
#----------------------------------------------

cd $TMP_DIR && \
    mkdir Maya${MAYA_MAJOR_VERSION}devkit && \
    cd Maya${MAYA_MAJOR_VERSION}devkit && \
      tar -xvzf $DOWNLOADS_DIR/Maya${MAYA_MAJOR_VERSION}_DEVKIT_Linux.tgz
cd / && \
      cp -R $TMP_DIR/Maya${MAYA_MAJOR_VERSION}devkit/devkitBase/cmake $MAYA_LOCATION && \
      cp -R $TMP_DIR/Maya${MAYA_MAJOR_VERSION}devkit/devkitBase/devkit $MAYA_LOCATION && \
      cp -R $TMP_DIR/Maya${MAYA_MAJOR_VERSION}devkit/devkitBase/include $MAYA_LOCATION && \
      cp -R $TMP_DIR/Maya${MAYA_MAJOR_VERSION}devkit/devkitBase/mkspecs $MAYA_LOCATION && \
      cp -R $TMP_DIR/Maya${MAYA_MAJOR_VERSION}devkit/devkitBase/lib $MAYA_LOCATION

# Extract Maya's QT libraries
cd $MAYA_LOCATION/include
tar xvf qt-5.6.1-include.tar.gz

cd $MAYA_LOCATION/cmake
tar xvf qt-5.6.1-cmake.tar.gz

cd $MAYA_LOCATION/mkspecs
tar xvf qt-5.6.1-mkspecs.tar.gz

#rm -rf $TMP_DIR
