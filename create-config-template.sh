#/bin/bash
CONFIG_PATH="/opt/kafka/config"

# check if we passed in an argument - used mostly for testing
if [ ! -z "$1" ]
then
  CONFIG_PATH="$(dirname $1/testfilename)"
fi
echo "${CONFIG_PATH}"

KAFKA_CONFIG="${CONFIG_PATH}/server.properties"
KAFKA_TEMPLATE="${KAFKA_CONFIG}.templates"
ZOOKEEPER_CONFIG="${CONFIG_PATH}/zookeeper.properties"
ZOOKEEPER_TEMPLATE="${ZOOKEEPER_CONFIG}.templates"

# build the ZooKeeper template
cat "${ZOOKEEPER_CONFIG}" \
  | sed -r "s/^(dataDir=)(.*)/\1{{ZOOKEEPER_DATA_DIR}}/g" \
  | sed -r "s/^(clientPort=)(.*)/\1{{ZOOKEEPER_CLIENT_PORT}}/g" \
  | sed -r "s/^(maxClientCnxns=)(.*)/\1{{ZOOKEEPER_MAX_CLIENT_CONNECTIONS}}/g" \
  > "${ZOOKEEPER_TEMPLATE}"

# build the Kafka template  
cat "${KAFKA_CONFIG}" \
  > "${KAFKA_TEMPLATE}"
  
