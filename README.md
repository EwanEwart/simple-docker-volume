# simple-docker-volume
## check apple volume capability

> $ `docker container prune`   
> WARNING! This will remove all stopped containers.  
> Are you sure you want to continue? [y/N] y  
> Deleted Containers:  
> c5d9279a43f5cf476296ba86f8447bdc15962201657bce7d62962930276673f2
> Total reclaimed space: 0B  

> $ `docker volume prune`  
> WARNING! This will remove all local volumes not used by at least one container.
> Are you sure you want to continue? [y/N] y
> Deleted Volumes:
> 0b9743c738828725bab18dfeff4c803e82d340410ace154e898a2339986d4039
> Total reclaimed space: 19B

> $ `./build-image.sh`  
> → Delete dangling images
> WARNING! This will remove all dangling images.
> Are you sure you want to continue? [y/N] y
> Total reclaimed space: 0B
> → Delete dangling images - alternative
> "docker rmi" requires at least 1 argument.
> See 'docker rmi --help'.
> Usage:  docker rmi [OPTIONS] IMAGE [IMAGE...]
> 
> Remove one or more images
> → Build an image from a Dockerfile
> Sending build context to Docker daemon  72.19kB
> Step 1/4 : FROM ubuntu
>  ---> f643c72bc252
> Step 2/4 : RUN mkdir /simple-vol-dir
>  ---> Using cache
>  ---> 83a50c4e48ae
> Step 3/4 : RUN echo "Simple Volume" > /simple-vol-dir/simple-volume
>  ---> Running in da086e91e4fb
> Removing intermediate container da086e91e4fb
>  ---> 2313266c762f
> Step 4/4 : VOLUME /simple-vol-dir
>  ---> Running in 72c4911348e8
> Removing intermediate container 72c4911348e8
>  ---> 93e2cf6dd1eb
> Successfully built 93e2cf6dd1eb
> Successfully tagged simple-volume-image:latest
> → Container-Run

> $ `docker volume ls`  
> DRIVER    VOLUME NAME  
> local     603f90027eaf66e6b7cc853e65f63346f15dabb834fa2aaadf771e236a7f28d1

> $ `docker volume inspect` 603f90027eaf66e6b7cc853e65f63346f15dabb834fa2aaadf771e236a7f28d1 
> [
>     {
>         "CreatedAt": "2020-12-28T15:39:29+01:00",
>         "Driver": "local",
>         "Labels": null,
>         "Mountpoint": "/var/lib/docker/volumes/603f90027eaf66e6b7cc853e65f63346f15dabb834fa2aaadf771e236a7f28d1/_data",
>         "Name": "603f90027eaf66e6b7cc853e65f63346f15dabb834fa2aaadf771e236a7f28d1",
>         "Options": null,
>         "Scope": "local"
>     }
> ]


> $ `sudo ls -l` /var/lib/docker/volumes/603f90027eaf66e6b7cc853e65f63346f15dabb834fa2aaadf771e236a7f28d1/_data
> total 4
> -rw-r--r-- 1 root root 14 Dec 28 15:39 simple-volume

> $ `sudo ls -l` /var/lib/docker/volumes/603f90027eaf66e6b7cc853e65f63346f15dabb834fa2aaadf771e236a7f28d1/_data/simple-volume
> -rw-r--r-- 1 root root 14 Dec 28 15:39 /var/lib/docker/volumes/603f90027eaf66e6b7cc853e65f63346f15dabb834fa2aaadf771e236a7f28d1/_data/simple-volume

> $ `sudo cat` /var/lib/docker/volumes/603f90027eaf66e6b7cc853e65f63346f15dabb834fa2aaadf771e236a7f28d1/_data/simple-volume
> Simple Volume

## Mac OS
*macOS* is **NOT** `a native host of the Docker engine`,  
which is why the Docker engine  
runs through `a Linux virtual machine (VM).`  
The path specified in a Docker volume  
is `a path on the virtual machine’s filesystem`.  
Acces can be gained for example  
by setting this alias in the shell's configuration file:  

> `alias dvmc='docker run -it --rm --privileged --pid=host alpine:edge nsenter -t 1 -m -u -n -i sh`

Once the `docker run ...` command has been run   
access can be gained to the docker managed data  
by executing the alias:

> $ `dvmc`

