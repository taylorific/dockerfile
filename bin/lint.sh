#!/bin/bash

BASE_DIR=$(pwd)
BIN_DIR="${BASE_DIR}/../../bin"
HADOLINT_DOCKER_IMAGE=taylorific/hadolint-amd64

lints_to_ignore=$(sed "s/#.*//" "${BIN_DIR}/hadolint-ignore" | sed '/^[[:space:]]*$/d' | sed 's/^/--ignore / ' | tr '\n' ' ')
docker container run --rm -i ${HADOLINT_DOCKER_IMAGE} hadolint ${lints_to_ignore} - < "Dockerfile"
