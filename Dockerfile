FROM ubuntu
RUN mkdir /simple-vol-dir
RUN echo "Simple Docker Volume" > /simple-vol-dir/simple-volume
# VOLUME /simple-vol-dir
