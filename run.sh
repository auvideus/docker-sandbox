#!/bin/bash

echo "Stopping sandbox environment..." && \
docker rm -f sandbox
echo "Building sandbox environment..." && \
docker build \
    --build-arg user=$USERNAME \
    --tag sandbox:latest . && \
echo "Running sandbox environment..." && \
docker run --detach --tty \
    -v $VOL_HOME:/opt/home \
    -v $VOL_DEV:/opt/dev \
    -v $VOL_SECURITY:/opt/security \
    -v //var/run/docker.sock:/var/run/docker.sock \
    --rm --name sandbox -h localhost sandbox:latest && \
winpty docker exec -it -u root sandbox bash -c 'cd /opt/dev/repos && fish'
                                
