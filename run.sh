#!/bin/bash

echo -e "\n----> BUILDING SANDBOX ENVIRONMENT\n"

docker build \
    --quiet \
    --build-arg user=$USERNAME \
    --tag sandbox:latest \
    .

echo -e "\n----> STARTING SANDBOX ENVIRONMENT\n"

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
docker logs sandbox

echo -e "\n----> RUNNING SANDBOX ENVIRONMENT\n"

winpty docker attach sandbox
