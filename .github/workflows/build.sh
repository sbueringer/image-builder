#!/bin/bash

set -euo pipefail


DATE=$(date +%Y%m%d-%H%M)

UBUNTU_VERSION="1910"
K8S_VERSION="v1.16.2"

SHORT_SHA="$(git rev-parse --short HEAD)"
MAKE_VERSION="build-qemu-ubuntu-${UBUNTU_VERSION}"
BUILD_VERSION="${UBUNTU_VERSION}-kube-${SHORT_SHA}-${DATE}"

echo "building image ubuntu-$BUILD_VERSION''"

export PACKER_FLAGS="-debug -var 'accelerator=none' -var 'cpus=2' -var 'disk_size=10240' -var 'memory=4096'"
export PACKER_LOG=1
export PACKER_LOG_PATH=/tmp/packer.log
tail -F ${PACKER_LOG_PATH} &

cd ./images/capi

make "${MAKE_VERSION}"

ls -la ./output/ubuntu-${UBUNTU_VERSION}-kube-${K8S_VERSION}/

echo -e "[INFO] Version of image: ${BUILD_VERSION}\n"
