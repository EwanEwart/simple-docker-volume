FROM ubuntu
RUN mkdir /simple-vol-dir
RUN echo "Simple Volume" > /simple-vol-dir/simple-volume
VOLUME /simple-vol-dir
