# start with open jdk image
FROM hypriot/rpi-java

# set the versions of kafka and scala we want to install
ARG kafka_ver=1.0.1
ARG scala_ver=2.12

# setup the environment vars that we'll be passing around to our install
ENV KAFKA_VER=$kafka_ver \
    SCALA_VER=$scala_ver
    
# seems like /tmp is where everyone likes to copy stuff too and then wipe out
COPY install.sh /tmp

#
# BOOTSTRAP: This is where we bootstrap the install and setup
#	Note: The reason for all of the continuations is to reduce
#	      number of docker incrementals
#
# install unzip wget curl
RUN apt-get install unzip wget curl \
# make our install script executable
  && chmod a+x install.sh \
# run install script
  && /tmp/install.sh \
# cleanup /tmp
  && rm -f /tmp/*

# this will be replaced later after I debug Kafka install
CMD ["/bin/sh"]
