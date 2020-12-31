#!/bin/bash

let docker_managed=0

prune () {
    if [[ docker_managed -eq 1 ]]; then
        echo "> container prune"
        docker container prune
        echo "> volume prune"
        docker volume prune
        echo "> image prune"
        docker image prune
        echo "> Delete dangling images - alternative"
        docker rmi -f `docker images -q -f dangling=true`
    else
        echo "> container prune"
        docker container prune
        echo "> volume prune"
        docker volume prune
        echo "> image prune"
        docker image prune
        echo "> Delete dangling images - alternative"
        docker rmi -f `docker images -q -f dangling=true`
        sudo rm -fR /tmp/volumes
    fi
}
build () {
    echo "> Build an Image based on a Dockerfile"
    docker build -t "simple-volume-image" .
}
build_keir () {
    # compile on another server
    export DOCKER_HOST=ssh://keir@192.168.188.222
    echo "→ DOCKER_HOST=$DOCKER_HOST"

}
docker_managed_volumes () {
    if [[ $docker_managed -eq 1 ]]; then
        echo "> Display file contents \"simple-volume-file\""
        sudo tree /var/lib/docker/volumes/
        sudo cat /var/lib/docker/volumes/simple-volume/_data/simple-volume-file
    else # host managed
        sudo tree /tmp/volumes
        sudo cat /tmp/volumes/simple-volume/simple-volume-file
    fi
}
run () {
    if [[ $docker_managed -eq 1 ]]; then
        echo "> Run Container based on an Image'"
        docker run \
            --name simple-volume-container \
            -v simple-volume:/simple-vol-dir \
            simple-volume-image
            # --rm \
        docker_managed_volumes
    else # host managed: mount a host volume
        echo "> Run Container based on an Image'"
        docker run \
            --name simple-volume-container \
            -v /tmp/volumes/simple-volume:/simple-vol-dir \
            simple-volume-image
            # --rm \
        docker_managed_volumes
    fi
}

if [[ $2 == "keir" ]]; then
    build_keir
fi

case "$1" in
"keir")
    build_keir
    ;;
"prune")
    prune
    ;;
"build")
    build
    ;;
"run")
    run
    ;;
"dmv")
    docker_managed_volumes
    ;;
*)
    echo -e "\n> Usage: $0 keir | prune | build | run | dmv\n"
    ;;
esac

:<<'COMMENT'
/*
if [[ $1 == "prune" ]]; then
    prune
fi
if [[ $1 == "build" ]]; then
    build
fi
if [[ $1 == "run"  ]]; then
    run
fi
COMMENT
