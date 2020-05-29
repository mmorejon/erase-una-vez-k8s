#!/usr/bin/env bash

## install dependencies
apt-get update && apt-get install -y \
  apt-transport-https \
  ca-certificates \
  curl \
  gnupg-agent \
  software-properties-common \
  bash-completion

## add keys for repositories
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
curl -fsSL https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -

## add repositories for docker and kubernetes
add-apt-repository \
  "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) \
  stable"

add-apt-repository \
  "deb https://apt.kubernetes.io/ kubernetes-xenial main"

# kubelet requires swap off
swapoff -a
sudo sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab

## create /etc/docker directory.
mkdir /etc/docker

## setup daemon.
cat <<EOF | sudo tee /etc/docker/daemon.json
{
  "exec-opts": ["native.cgroupdriver=systemd"],
  "log-driver": "json-file",
  "log-opts": {
    "max-size": "100m"
  },
  "storage-driver": "overlay2"
}
EOF

## install docker, kubernetes, kubectl and kubeadm
apt-get update && apt-get install -y \
  docker-ce=5:19.03.9~3-0~ubuntu-focal \
  docker-ce-cli=5:19.03.9~3-0~ubuntu-focal \
  kubelet=${KUBERNETES_VERSION}-00 \
  kubeadm=${KUBERNETES_VERSION}-00 \
  kubectl=${KUBERNETES_VERSION}-00

## setup node ip into kubelet configuration
## https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/install-kubeadm/#check-network-adapters
IPADDR=`ip -4 addr show eth1 | grep inet |  awk '{print $2}' | cut -f1 -d/`
sed -i '/\[Service\]/a Environment="KUBELET_EXTRA_ARGS=--node-ip='$IPADDR'"' /etc/systemd/system/kubelet.service.d/10-kubeadm.conf
systemctl daemon-reload
systemctl restart kubelet

## add vagrant into docker group
usermod -aG docker vagrant