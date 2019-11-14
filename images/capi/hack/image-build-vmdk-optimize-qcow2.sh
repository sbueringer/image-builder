#!/usr/bin/env bash

BUILD_DIR=$1

echo "Compressing qcow2"
qemu-img convert -f qcow2 -O qcow2 -c ${BUILD_DIR}/qemu-kube-v1.16.2 ${BUILD_DIR}/qemu-kube-v1.16.2.qcow2

echo "Converting qcow2 to streamOptimized vmdk"
qemu-img convert -f qcow2 -O vmdk -o subformat=streamOptimized ${BUILD_DIR}/qemu-kube-v1.16.2 ${BUILD_DIR}/qemu-kube-v1.16.2.vmdk
