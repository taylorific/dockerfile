#!/bin/bash

# set -eux
set -eu
set -o pipefail

SCRIPT_PATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
BIN_DIR="${SCRIPT_PATH}"
BASE_DIR=$(pwd)
IMAGE_NAME="$(${BIN_DIR}/image-name.sh)"
DOCKER_REPO="docker.io/taylorific"
SOURCE_IMAGE="${DOCKER_REPO}/${IMAGE_NAME}"

tags="$(${BIN_DIR}/list-tags.sh)"
while read -r tag; do
  echo "Tagging ${tag}"
  docker image tag "${SOURCE_IMAGE}" "${tag}"
done <<< "${tags}"
