#/bin/sh

# https://kafka.apache.org/downloads
# KAFKA_VER = the version of Kafka we are going to download
# SCALA_VER = the version of Scala it is built with
# download it as kafka.tgz

# Section: DOWNLOADS

# get the closest apache mirror got this from SO
# https://stackoverflow.com/questions/21534797/finding-the-closest-apache-software-foundation-mirror-programatically
# surrounding the command with $(cmd inside) gets the stdout and sticks it in the variable 
CLOSEST_MIRROR_URL="$(curl -s 'https://www.apache.org/dyn/closer.cgi?as_json=1' | jq --raw-output '.preferred')"
# now we can download the specific files and version
DOWNLOAD_URL="${CLOSEST_MIRROR_URL}kafka/${KAFKA_VER}/kafka_${SCALA_VER}-${KAFKA_VER}.tgz"
# always bring back as a single file name to make the rest of the scripts easier to work with
DOWNLOAD_FILE="/tmp/kafka.tgz"
# download the file quietly and out to our output filename
wget -q "${DOWNLOAD_URL}" -O ${DOWNLOAD_FILE}
 

# Section: INSTALL
# going a little off this article for install https://hevodata.com/blog/how-to-set-up-kafka-on-ubuntu-16-04/

# untar the file to /opt 
tar xvf /tmp/kafka.tgz -C /opt
# rename to /opt/kafka because it will come out as /opt/kafka_{scala_ver}_{kafka_ver} ickkkkk
mv /opt/kafka* /opt/kafka

# add kafka user
adduser --system --no-create-home --disabled-password --disabled-login kafka

# make our log data directory for kafka
mkdir -p /var/lib/kafka/data

# make our data directory for zookeeper
mkdir -p /var/lib/zookeeper/data

# copy the template config generator script and make it executable
cp /tmp/create-config-files.sh /opt/kafka/bin
chmod a+x /opt/kafka/bin/create-config-files.sh 

# copy server start file
cp /tmp/server-start.sh /opt/kafka/bin
# make server start executable
chmod a+x /opt/kafka/bin/server-start.sh

# change ownership of the kafka directories to the kafka user
chown -R kafka:nogroup /opt/kafka
chown -R kafka:nogroup /var/lib/kafka
chown -R kafka:nogroup /var/lib/zookeeper

# convert our properties files to a template
/tmp/create-config-template.sh /opt/kafka/config

# remove the server properties files for ZooKeeper and Kafka
rm /opt/kafka/config/server.properties
rm /opt/kafka/config/zookeeper.properties
