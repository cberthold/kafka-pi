#/bin/bash
SCRIPT_PATH="$( cd "$( dirname "$0" )" && pwd )"
CONFIG_PATH="${SCRIPT_PATH}/../config"
ZOOKEEPER_CONFIG="${CONFIG_PATH}/zookeeper.properties"
ZOOKEEPER_TEMPLATE="${ZOOKEEPER_CONFIG}.templates"

cat "${ZOOKEEPER_CONFIG}" \
  | sed -r "s/^(dataDir=)(.*)/\1{{ZOOKEEPER_DATA_DIR}}/g" \
  | sed -r "s/^(clientPort=)(.*)/\1{{ZOOKEEPER_CLIENT_PORT}}/g" \
  | sed -r "s/^(maxClientCnxns=)(.*)/\1{{ZOOKEEPER_MAX_CLIENT_CONNECTIONS}}/g" \
  > "${ZOOKEEPER_TEMPLATE}"