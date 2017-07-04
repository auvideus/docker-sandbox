#!/bin/bash

echo "Stopping sandbox" && \
docker rm -f sandbox
echo "Building sandbox" && \
docker build --tag sandbox:latest . && \
echo "Running sandbox" && \
docker run -dt -v roothome:/root -v d:/sync-home/dev/docker:/opt/sdev -v d:/no-sync/dev/docker:/opt/dev --rm --name sandbox -h localhost sandbox:latest && \
winpty docker exec -it -u root sandbox fish
