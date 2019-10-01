#!/usr/bin/env bash
set -e

ROOTDIR=/home/hans/SQUEEZE
export MAYA_USD_ROOT=$ROOTDIR/maya_usd

rm -fr $MAYA_USD_ROOT
mkdir $MAYA_USD_ROOT

mkdir $MAYA_USD_ROOT/icons
mkdir $MAYA_USD_ROOT/scripts
mkdir $MAYA_USD_ROOT/plug-ins
mkdir $MAYA_USD_ROOT/maya_lib
mkdir $MAYA_USD_ROOT/usd

# Create a temporary container to get files from the image
maya_docker_image_id=`docker create usd-docker/maya2019-usd:18.11-centos7`

# maya_docker_image_id=`docker images --format="{{.Repository}} {{.ID}}" | grep maya2019-usd | head -1 | cut -d' ' -f2`
# docker container ls  | grep maya2019-usd | head -1 | cut -d' ' -f1


# Get usd lib
# docker cp ${maya_docker_image_id}:/opt/usd/usd/18.11/lib $MAYA_USD_ROOT/

# Get USD install data
docker cp ${maya_docker_image_id}:/opt/usd/usd/18.11 $MAYA_USD_ROOT/usd
docker rm -v $maya_docker_image_id

# Copy USD lib
cp -r $MAYA_USD_ROOT/usd/18.11/lib $MAYA_USD_ROOT

# Copy maya plugin
cp -r $MAYA_USD_ROOT/usd/18.11/third_party/maya/plugin/* $MAYA_USD_ROOT/plug-ins/.
# Copy maya lib
cp $MAYA_USD_ROOT/usd/18.11/third_party/maya/lib/*.so $MAYA_USD_ROOT/maya_lib/.

# Copy mel files
cp $MAYA_USD_ROOT/usd/18.11/third_party/maya/lib/usd/usdMaya/resources/*.mel $MAYA_USD_ROOT/scripts/.
# Copy mel script
cp $MAYA_USD_ROOT/usd/18.11/third_party/maya/lib/usd/usdMaya/resources/*.xpm $MAYA_USD_ROOT/icons/.


# Copy mod file to default location
cp -f MayaUSD.mod ~/maya/2019/modules

