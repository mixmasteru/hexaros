#!/bin/bash
PROG=${1:-/bin/bash}

export containerId=$(docker ps -fname=foxyros -q)
xhost +local:`docker inspect --format='' $containerId`
docker exec -it noeticros $PROG
#docker start $containerId
