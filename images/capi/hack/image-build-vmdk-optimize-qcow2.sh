#!/usr/bin/env bash

BUILD_DIR=$1
IMAGE_NAME=$2

echo "Converting qcow2 to streamOptimized vmdk"
qemu-img convert -f qcow2 -O vmdk -o subformat=streamOptimized ${BUILD_DIR}/${IMAGE_NAME} ${BUILD_DIR}/${IMAGE_NAME}.vmdk

echo "Compressing qcow2"
qemu-img convert -f qcow2 -O qcow2 -c ${BUILD_DIR}/${IMAGE_NAME} ${BUILD_DIR}/${IMAGE_NAME}.qcow2
