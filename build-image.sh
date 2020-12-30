#!/usr/bin/bash

prune () {
    echo "> container prune"
    docker container prune
    echo "> volume prune"
    docker volume prune
    echo "> image prune"
    docker image prune
    echo "> Delete dangling images - alternative"
    docker rmi -f `docker images -q -f dangling=true`
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
    echo "> Display file contents \"simple-volume\""
    sudo tree /var/lib/docker/volumes/
    cat /var/lib/docker/volumes/simple-volume/_data/simple-volume
}
run () {
    echo "> Run Container based on an Image'"
    docker run \
        --name simple-volume-container \
        -v simple-volume:/simple-vol-dir \
        simple-volume-image
        # --rm \
    docker_managed_volumes
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
