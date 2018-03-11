# start with open jdk image
FROM arm32v7/openjdk

# set the versions of kafka and scala we want to install
ARG kafka_ver=1.0.1
ARG scala_ver=2.12

# setup the environment vars that we'll be passing around to our install
ENV KAFKA_VER=$kafka_ver \
    SCALA_VER=$scala_ver
    
# seems like /tmp is where everyone likes to copy stuff too and then wipe out
COPY install.sh create-config-template.sh create-config-files.sh server-start.sh /tmp/

#
# BOOTSTRAP: This is where we bootstrap the install and setup
#	Note: The reason for all of the continuations is to reduce
#	      number of docker incrementals
#
# run our commands
RUN \
# update an expired key ring
  apt-key adv --recv-keys --keyserver keys.gnupg.net 92BF1079 \
# update apt-get
  && apt-get update \
# install packages
  && apt-get install -y \
  	curl \
  	jq \ 
  	unzip \
  	wget \
# clean up apt-get https://docs.docker.com/develop/develop-images/dockerfile_best-practices/#run
  && rm -rf /var/lib/apt/lists/* \
# make our install script executable
  && chmod a+x /tmp/install.sh \
# run install script
  && /tmp/install.sh \
# cleanup /tmp
  && rm -f /tmp/*

# expose client port for ZooKeeper
EXPOSE 2181
# expose the peer and election ports for ZooKeeper
EXPOSE 2888
EXPOSE 3888

# expose listener ports for Kafka
# Plaintext - this is the only one supported thus far but might as well document it for later
EXPOSE 9091
# SSL
#EXPOSE 9092
# SASL SSL
#EXPOSE 9093

# expose data volumes
VOLUME ["/var/lib/kafka/data","/var/lib/zookeeper/data"]

# this will be replaced later after I debug Kafka install
CMD ["/bin/bash"]
