#!/usr/bin/env bash

set -euo pipefail

sudo apt update && sudo apt-get install -y \
    unzip \
    wget \
    curl \
    make \
    python3 \
    qemu-system \
    git \
    jq \
    rsync

cd ./images/capi

make deps-qemu
