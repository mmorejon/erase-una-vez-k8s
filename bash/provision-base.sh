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

# Create /etc/docker directory.
mkdir /etc/docker

# Setup daemon.
cat <<EOF | tee /etc/docker/daemon.json
{
  "exec-opts": ["native.cgroupdriver=systemd"],
  "log-driver": "json-file",
  "log-opts": {
    "max-size": "100m"
  },
  "storage-driver": "overlay2"
}
EOF

# Setup containerd
cat <<EOF | tee /etc/modules-load.d/containerd.conf
overlay
br_netfilter
EOF

modprobe overlay
modprobe br_netfilter

# Setup required sysctl params, these persist across reboots.
cat <<EOF | tee /etc/sysctl.d/99-kubernetes-cri.conf
net.bridge.bridge-nf-call-iptables  = 1
net.ipv4.ip_forward                 = 1
net.bridge.bridge-nf-call-ip6tables = 1
EOF

# Apply sysctl params without reboot
sysctl --system

# Install docker, containerd, kubernetes, kubectl and kubeadm
apt-get update && apt-get install -y \
  containerd.io=1.4.3-1 \
  docker-ce=5:19.03.9~3-0~ubuntu-focal \
  docker-ce-cli=5:19.03.9~3-0~ubuntu-focal \
  kubelet=${KUBERNETES_VERSION}-00 \
  kubeadm=${KUBERNETES_VERSION}-00 \
  kubectl=${KUBERNETES_VERSION}-00

# Configure containerd
mkdir -p /etc/containerd
containerd config default | tee /etc/containerd/config.toml

# Restart containerd
systemctl restart containerd

## setup node ip into kubelet configuration
## https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/install-kubeadm/#check-network-adapters
IPADDR=`ip -4 addr show eth1 | grep inet |  awk '{print $2}' | cut -f1 -d/`
sed -i '/\[Service\]/a Environment="KUBELET_EXTRA_ARGS=--node-ip='$IPADDR'"' /etc/systemd/system/kubelet.service.d/10-kubeadm.conf
systemctl daemon-reload
systemctl restart kubelet

## add vagrant into docker group
usermod -aG docker vagrant