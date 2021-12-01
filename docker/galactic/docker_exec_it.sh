#!/bin/bash
PROG=${1:-rqt}
CONTAINER="galacticros"

export containerId=$(docker ps -fname=$CONTAINER -q)
xhost +local:`docker inspect --format='{{ .Config.Hostname }}' $containerId`
docker exec -it $CONTAINER $PROG


# 1 Pipe from a file
#sudo docker exec --interactive CONTAINER_NAME /bin/bash < the_beginning.sh | tee the_beginning_output.txt`

#2a Pipe by piping
#echo "echo This is how we pipe to docker exec" | sudo docker exec --interactive CONTAINER_NAME /bin/bash -
