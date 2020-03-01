#!/usr/bin/env bash

packer_version=1.4.3

sudo apt-get install qemu-system-x86 qemu-kvm qemu libvirt-bin virt-manager virtinst bridge-utils cpu-checker virt-viewer
sudo kvm-ok

sudo apt update && sudo apt-get install -y \
    unzip \
    wget \
    curl \
    make \
    python3 \
    qemu-system \
    python-pip \
    git \
    jq \
    rsync

wget --quiet -O packer.zip https://releases.hashicorp.com/packer/${packer_version}/packer_${packer_version}_linux_amd64.zip \
 && unzip packer.zip \
 && rm packer.zip \
 && sudo mv packer /usr/local/bin/ \
 && packer version

pip install ansible && ansible --version
