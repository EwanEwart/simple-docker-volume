#!/usr/bin/bash

# compile on another server
# export DOCKER_HOST=ssh://keir@192.168.188.222
# echo "→ DOCKER_HOST=$DOCKER_HOST"

echo "→ Delete dangling images"
docker image prune

echo "→ Delete dangling images - alternative"
docker rmi -f `docker images -q -f dangling=true`

# "→ Usage:  docker build [OPTIONS] PATH | URL | -"
echo "→ Build an image from a Dockerfile"
docker build . -t "simple-volume-image"

# echo "→ Run"
# echo "→ → Raw-Run"
# ./main.go

echo "→ Container-Run"
docker run \
    --name simple-volume-container \
    simple-volume-image
    # -v simple-volume:/go/bin \
    # --rm \
