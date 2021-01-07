#!/bin/bash

action_to_take=$1
let docker_managed_volume=1

# Actions
prune () {
    echo "> container prune"
    echo 'y' | docker container prune
    echo "> volume prune"
    echo 'y' | docker volume prune
    echo "> image prune"
    echo 'y' | docker image prune
    echo "> Delete dangling images - alternative"
    echo 'y' | docker rmi -f `docker images -q -f dangling=true`

    if [[ docker_managed_volume -eq 1 ]]; then
        echo ""
    else
        echo "> Delete dangling images - alternative"
        docker rmi -f `docker images -q -f dangling=true`
        sudo rm -fR ~/volumes
    fi
}
build () {
    echo "> Build an Image based on a Dockerfile and build context .==current dir"
    if [[ docker_managed_volume -eq 1 ]]; then
        echo ""
    else
        # Host volume dir created by docker if not present
        echo "> Create Host Volume: simple-volume"
        mkdir -p ~/volumes/simple-volume
    fi
    docker build --no-cache  -t "simple-volume-image" .
}
build_keir () {
    # compile on another server
    export DOCKER_HOST=ssh://keir@192.168.188.222
    echo "> DOCKER_HOST=$DOCKER_HOST"

}
view () {
    if [[ $docker_managed_volume -eq 1 ]]; then
        echo "> Display file contents \"simple-vol-file\""
        sudo tree /var/lib/docker/volumes/
        sudo cat /var/lib/docker/volumes/simple-volume/_data/simple-vol-file
    else # host managed volume
        sudo tree ~/volumes
        sudo cat ~/volumes/simple-volume/simple-vol-file
    fi
}
run () {
    if [[ $docker_managed_volume -eq 1 ]]; then
        echo "> Run, i.e., create and start, Container based on an Image'"
        echo "> Named Volume, docker managed volume"
        docker run \
            --name simple-volume-container \
            -v simple-volume:/simple-vol-dir \
            simple-volume-image
            # --rm \
    else # host managed: mount a host volume
        echo "> Run, i.e, create and start, Container based on an Image'"
        echo "> Hosted volume, NOT managed by docker"
        docker run \
            --name simple-volume-container \
            -v ~/volumes/simple-volume:/simple-vol-dir \
            simple-volume-image \
            # -it \
            # /bin/bash
            # --rm \
    fi
}
dvmc () { # enter macOS docker VM console
    docker run -it --rm --privileged --pid=host alpine:edge nsenter -t 1 -m -u -n -i sh
}

if [[ $2 == "keir" ]]; then
    build_keir
fi

case "$action_to_take" in
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
"view")
    view
    ;;
"view")
    view
    ;;
"dvmc")
    dvmc
    ;;
*)
    echo -e "\n> Usage: $0 prune | build | run | view | dvmc  docker_managed_volume=1 [ keir ]   \n"
    ;;
esac

:<<'COMMENT'
End of script
COMMENT
