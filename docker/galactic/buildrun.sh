#!/bin/bash
FOLDER=${1}

docker stop galacticros
docker build --tag myros:galactic .
docker run -d \
    --name galacticros \
    --rm \
    --gpus all \
    --env="DISPLAY" \
    --env="QT_X11_NO_MITSHM=1" \
    --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
    --volume="$FOLDER:/root/ros:rw" \
    -p 127.0.0.1:2222:22 \
    myros:galactic
