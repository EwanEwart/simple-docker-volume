FROM ubuntu

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
# Ubuntu
# RUN cat /etc/issue
# RUN cat /etc/os-release

VOLUME [ "/simple-vol-dir" ]
CMD echo "Simple Docker Volume" > /simple-vol-dir/simple-vol-file;df;ls -dl /simple-vol-dir;ls -l /simple-vol-dir;ls -l /simple-vol-dir/simple-vol-file;pwd;
