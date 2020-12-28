FROM ubuntu
RUN mkdir /simple-vol-dir
RUN echo "Simple Docker-File" > /simple-vol-dir/simple-vol-file
VOLUME /simple-vol-dir
