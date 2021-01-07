FROM ubuntu:18.04
# FROM alpine
# FROM bashell/alpine-bash

# # # Unnecessary --- V
# 
WORKDIR /simple-vol-dir
RUN echo "Simple Docker Volume" > simple-vol-file
RUN cat simple-vol-file

# Install make
# RUN which apt
# RUN apt update
# RUN apt install make
# RUN which make

# Which OS
# RUN uname -a
# RUN cat /etc/issue
# RUN cat /etc/os-release
# RUN cat /simple-vol-dir/simple-vol-file
# RUN which df

# # # Volume: works
VOLUME [ "/simple-vol-dir" ]
CMD echo "Simple Docker Volume" > /simple-vol-dir/simple-vol-file;df;ls -dl /simple-vol-dir;ls -l /simple-vol-dir;ls -l /simple-vol-dir/simple-vol-file;pwd;
# CMD echo "Simple Docker Volume" > simple-vol-file;df;ls -dl .;ls -l;ls -l simple-vol-file;pwd;
# CMD df; 
