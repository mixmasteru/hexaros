#!/bin/bash
FOLDER=${1}

docker stop foxyros
docker build --tag myros:foxy .
docker run -d \
    --name foxyros \
    --rm \
    --device=/dev/dri:/dev/dri \
    --env="DISPLAY" \
    --env="QT_X11_NO_MITSHM=1" \
    --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
    --volume="$FOLDER:/root/ros:rw" \
    -p 127.0.0.1:2223:22 \
    myros:foxy

#export containerId=$(docker ps -l -q)
#xhost +local:`docker inspect --format='' $containerId`
#docker start $containerId
