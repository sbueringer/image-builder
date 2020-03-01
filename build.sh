#!/bin/bash

set -euo pipefail


DATE=$(date +%Y%m%d-%H%M)

UBUNTU_VERSION="1910"
K8S_VERSION="v1.16.2"

git clone -b caas-1910 https://github.com/sbueringer/image-builder.git /tmp/image-builder
cd /tmp/image-builder/images/capi

SHORT_SHA="$(git rev-parse --short HEAD)"
MAKE_VERSION="build-qemu-ubuntu-${UBUNTU_VERSION}"
BUILD_VERSION="${UBUNTU_VERSION}-kube-${SHORT_SHA}-${DATE}"

echo "builing image ubuntu-$BUILD_VERSION''"

export PACKER_FLAGS="-debug"
export PACKER_LOG=1
export PACKER_LOG_PATH=/tmp/packer.log
tail -F ${PACKER_LOG_PATH} &

#make "${MAKE_VERSION}"

mkdir -p ./output/ubuntu-${UBUNTU_VERSION}-kube-${K8S_VERSION}
echo "test" > ./output/ubuntu-${UBUNTU_VERSION}-kube-${K8S_VERSION}/qemu-kube-v1.16.2.qcow2

ls -la ./output/ubuntu-${UBUNTU_VERSION}-kube-${K8S_VERSION}/

echo -e "[INFO] Version of image: ${BUILD_VERSION}\n"
