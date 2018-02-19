#!/bin/bash

echo -e "----> REMOVING SANDBOX ENVIRONMENT\n"

docker rm --force sandbox
set -e

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
    --tty \
    --detach \
    -v $VOL_HOME:/opt/home \
    -v $VOL_DEV:/opt/dev \
    -v $VOL_SECURITY:/opt/security \
    -v //var/run/docker.sock:/var/run/docker.sock \
    sandbox:latest

echo -e "\n----> RUNNING SANDBOX ENVIRONMENT\n"

winpty docker exec -it sandbox fish
