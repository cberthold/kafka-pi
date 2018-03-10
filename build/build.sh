#/bin/sh
SCRIPT_PATH="$( cd "$( dirname "$0" )" && pwd )"
BUILD_PATH="${SCRIPT_PATH}/.."
echo ${BUILD_PATH}
cd ${BUILD_PATH}
pwd
docker build .