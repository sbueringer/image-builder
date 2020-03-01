#!/usr/bin/env bash

packer_version=1.4.3

apt update && apt-get install -y \
    unzip \
    wget \
    curl \
    make \
    python3 \
    qemu-system \
    python-pip \
    git \
    jq \
    rsync \
    tigervnc-viewer

wget --quiet -O packer.zip https://releases.hashicorp.com/packer/${packer_version}/packer_${packer_version}_linux_amd64.zip \
 && unzip packer.zip \
 && rm packer.zip \
 && mv packer /usr/local/bin/

pip install ansible
