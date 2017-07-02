#!/bin/bash

echo "Stopping sandbox"
docker rm -f sandbox
echo "Building sandbox"
docker build --tag sandbox:latest .
echo "Running sandbox"
docker run -dt -v d:/no-sync/dev:/opt/dev --rm --name sandbox -h localhost sandbox:latest
winpty docker exec -it -u root sandbox fish
