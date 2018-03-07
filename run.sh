#!/bin/bash

echo -e "\n----> BUILDING SANDBOX CONTAINER\n"

docker build \
    --build-arg user=$USERNAME \
    --tag sandbox:latest \
    .

echo -e "\n----> RUNNING SANDBOX CONTAINER\n"

docker run \
    --name sandbox \
    --hostname localhost \
    --rm \
    --interactive \
    --tty \
    --detach \
    -v $VOL_HOME:/opt/home \
    -v $VOL_DEV:/opt/dev \
    -v $VOL_SECURITY:/opt/security \
    -e SANDBOX_REPO_NAME=$SANDBOX_REPO_NAME \
    -v //var/run/docker.sock:/var/run/docker.sock \
    sandbox:latest

echo -e "\n----> SHOWING CONTAINER OUTPUT\n"

docker logs sandbox

echo -e "\n----> ATTACHING TO SANDBOX CONTAINER\n"

winpty docker attach sandbox
