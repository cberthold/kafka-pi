#/bin/bash

# create properties files based on passed in environment vars
/opt/kafka/bin/create-config-files.sh

# start zookeeper
/opt/kafka/bin/zookeeper-server-start.sh -daemon /opt/kafka/config/zookeeper.properties

# wait a moment while ZooKeeper starts up
#sleep 10s

# start kafka