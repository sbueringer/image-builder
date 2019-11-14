#!/usr/bin/env bash

BUILD_DIR=$1

qemu-img convert -f qcow2 -O vmdk ${BUILD_DIR}/qemu-kube-v1.16.2 ${BUILD_DIR}/qemu-kube-v1.16.2.vmdk
