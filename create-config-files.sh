#/bin/bash
CONFIG_PATH="/opt/kafka/config"

# check if we passed in an argument - used mostly for testing
if [ ! -z "$1" ]
then
  CONFIG_PATH="$(dirname $1/testfilename)"
fi
echo "Building ZooKeeper and Kafka configuration files in: ${CONFIG_PATH}"

KAFKA_CONFIG="${CONFIG_PATH}/server.properties"
KAFKA_TEMPLATE="${KAFKA_CONFIG}.templates"
ZOOKEEPER_CONFIG="${CONFIG_PATH}/zookeeper.properties"
ZOOKEEPER_TEMPLATE="${ZOOKEEPER_CONFIG}.templates"

# reasonable defaults - ZooKeeper
DEFAULT_ZOOKEEPER_DATA_DIR="/var/lib/zookeeper/data"
DEFAULT_ZOOKEEPER_CLIENT_PORT="2181"
DEFAULT_ZOOKEEPER_MAX_CLIENT_CONNECTIONS="0"

# reasonable defaults - Kafka

# build the ZooKeeper config files from the template
cat "${ZOOKEEPER_TEMPLATE}" \
  | sed -e "s|{{ZOOKEEPER_DATA_DIR}}|${ZOOKEEPER_DATA_DIR:-$DEFAULT_ZOOKEEPER_DATA_DIR}|g" \
  | sed -e "s|{{ZOOKEEPER_CLIENT_PORT}}|${ZOOKEEPER_CLIENT_PORT:-$DEFAULT_ZOOKEEPER_CLIENT_PORT}|g" \
  | sed -e "s|{{ZOOKEEPER_MAX_CLIENT_CONNECTIONS}}|${ZOOKEEPER_MAX_CLIENT_CONNECTIONS:-$DEFAULT_ZOOKEEPER_MAX_CLIENT_CONNECTIONS}|g" \
  > "${ZOOKEEPER_CONFIG}"

# build the Kafka template  
cat "${KAFKA_TEMPLATE}" \
  > "${KAFKA_CONFIG}"


