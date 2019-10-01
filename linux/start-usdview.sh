#!/usr/bin/env bash
set -e

# # install nvidia-docker
#distribution=$(. /etc/os-release;echo $ID$VERSION_ID)
#curl -s -L https://nvidia.github.io/nvidia-docker/$distribution/nvidia-docker.repo | sudo tee /etc/yum.repos.d/nvidia-docker.repo
#sudo yum install -y nvidia-container-toolkit
#sudo systemctl restart docker 

docker build -t test_gui -f centos7/pixar_usd/Dockerfile_usdview .

docker run -it --rm \
       -e DISPLAY=$DISPLAY \
       -v /tmp/.X11-unix:/tmp/.X11-unix \
       -v /tmp/docker:/tmp/docker \
       test_gui
       
       
#docker run --runtime=nvidia \
#           --name "usd-docker" \
#           --rm -it \
#           --env DISPLAY \
#           -v /tmp/.X11-unix:/tmp/.X11-unix \
#           --env QT_X11_NO_MITSHM=1 \
#           -v="$HOME:/home/usd:rw" \
#           -v="$(dirname `pwd`)/data:/data:rw" \
#           "usd-docker/usd:latest-centos7" "$@"
#       