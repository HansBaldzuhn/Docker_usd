#!/usr/bin/env bash
#set -e

ROOTDIR=/home/hans/SQUEEZE
export USD_ROOT=$ROOTDIR/USD

#rm -fr $USD_ROOT
mkdir -p $USD_ROOT

# Create a temporary container to get files from the image
# image_id=`docker create usd-docker/pixar-usd:latest-centos7`
image_id=`docker create usd-docker/adsk_maya-usd_shared:latest-centos7`
#image_id=`docker create usd-docker/pixar-usd-monolithic:latest-centos7`



# Get USD install data
docker cp ${image_id}:/opt/usd/maya_usd/maya2019_usd2019 $USD_ROOT
docker cp ${image_id}:/opt/usd/usd/19.05_shared $USD_ROOT
#docker cp ${image_id}:/opt/usd/usd/19.05_Monolithic $USD_ROOT
docker rm -v $image_id

#The following in your PATH environment variable:
#/opt/usd/usd/19.05/bin
#echo export PATH="$PATH:$USD_ROOT/19.05/bin" >> ~/.bashrc
#The following in your PYTHONPATH environment variable:
#echo export PHYTONPATH="$PYTHONOATH:$USD_ROOT/19.05/lib/python" >> ~/.bashrc
