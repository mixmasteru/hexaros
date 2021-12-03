#!/bin/bash
PROG=${1:-bash}
CONTAINER="galacticros"

export containerId=$(docker ps -fname=$CONTAINER -q)
xhost +local:`docker inspect --format='{{ .Config.Hostname }}' $containerId`
docker exec galacticros bash -c "cat .env" > .env
docker exec -it --env-file .env $CONTAINER $PROG
