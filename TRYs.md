
# Packer build

Start (with ui and changed boot_wait)

````bash
cd images/capi

# configure VMWare Workstation
sudoedit /etc/vmware/netmap.conf
# Add:
#network0.name = "nat"
#network0.device = "vmnet8"

# debug only
export PACKER_LOG=1
export PACKER_LOG_PATH=/tmp/debug.log

make build-ova-ubuntu-1804
````

Rerun Ansible if it fails (adjust ips):

````bash
ansible-playbook --extra-vars "packer_build_name=ubuntu-1804 packer_builder_type=vmware-iso -o IdentitiesOnly=yes"  /home/fedora/code/gopath/src/sigs.k8s.io/capi-dev/image-builder/images/capi/ansible/playbook.yml  --extra-vars "packer_http_addr=172.16.38.1:8290" --extra-vars "kubernetes_rpm_repo=https://packages.cloud.google.com/yum/repos/kubernetes-el7-x86_64 kubernetes_rpm_gpg_key='https://packages.cloud.google.com/yum/doc/yum-key.gpg https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg' kubernetes_rpm_gpg_check=True kubernetes_deb_repo='https://apt.kubernetes.io/ kubernetes-xenial' kubernetes_deb_gpg_key=https://packages.cloud.google.com/apt/doc/apt-key.gpg kubernetes_cni_version=0.7.5-00 kubernetes_cni_semver=v0.7.5 kubernetes_cni_source=pkg kubernetes_semver=v1.15.0 kubernetes_source=pkg kubernetes_version=1.15.0-00"  -i "172.16.38.129," -e "ansible_user=ubuntu ansible_ssh_pass=ubuntu" -c paramiko
````

Or with 
````
ansible_ssh_user=ubuntu ansible_ssh_private_key_file=~/.ssh/id_rsa.capi
````

Post processing

````bash
chown -R fedora:wheel ./output

# Add file size to manifest: ls -la ./output/ubuntu-1804+kube-v1.15.0/ubuntu-1804.vmdk
cp ./packer-manifest.json output/ubuntu-1804+kube-v1.15.0

./hack/image-build-ova.py ./output/ubuntu-1804+kube-v1.15.0

./hack/image-post-create-config.sh ./output/ubuntu-1804+kube-v1.15.0
````

# Alternative download 

from http://storage.googleapis.com/capv-images/


# Upload image

```bash
qemu-img convert -f vmdk -O qcow2 -c ./output/ubuntu-1804-kube-v1.16.2/ubuntu-1804.ova.vmdk ./output/ubuntu-1804-kube-v1.16.2/ubuntu-1804.ova.qcow2

dhc_openstack os1pi020
openstack image create --disk-format vmdk \
  --private \
  --container-format bare \
  --property vmware_adaptertype="lsiLogicsas" \
  --property vmware_disktype="streamOptimized" \
  --property vmware_ostype="ubuntu64Guest" \
  --file ./output/ubuntu-1804-kube-v1.16.2/ubuntu-1804.ova.vmdk ubuntu-1804-kube-v1.16.2

dhc_openstack cluster-api-testing
openstack image create --disk-format qcow2 \
  --private \
  --container-format bare \
  --file ./output/ubuntu-1804-kube-v1.16.2/ubuntu-1804.ova.qcow2 ubuntu-1804-kube-v1.16.2

```