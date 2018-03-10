#/bin/sh

# https://kafka.apache.org/downloads
# KAFKA_VER = the version of Kafka we are going to download
# SCALA_VER = the version of Scala it is built with
# download it as kafka.tgz
wget https://www.apache.org/dyn/closer.cgi?path=/kafka/${KAFKA_VER}/kafka_${SCALA_VER}-${KAFKA_VER}.tgz -f kafka.tgz 