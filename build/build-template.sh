#/bin/bash
SCRIPT_PATH="$( cd "$( dirname "$0" )" && pwd )"
CONFIG_PATH="${SCRIPT_PATH}/../config"
ZOOKEEPER_CONFIG="${CONFIG_PATH}/zookeeper.properties"
ZOOKEEPER_TEMPLATE="${ZOOKEEPER_CONFIG}.templates"

cp "${ZOOKEEPER_CONFIG}" "${ZOOKEEPER_TEMPLATE}"