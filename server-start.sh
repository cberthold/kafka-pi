#/bin/bash

# create properties files based on passed in environment vars
/opt/kafka/bin/create-config-files.sh

# start zookeeper
/opt/kafka/bin/zookeeper-server-start.sh -daemon /opt/kafka/config/zookeeper.properties

# wait a moment while ZooKeeper starts up
sleep 4s

# start kafka
/opt/kafka/bin/kafka-server-start.sh /opt/kafka/config/server.properties
