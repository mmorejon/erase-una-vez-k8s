#!/usr/bin/env bash

## initialize kubernetes cluster
kubeadm init \
  --kubernetes-version ${KUBERNETES_VERSION} \
  --apiserver-advertise-address ${MASTER_IP} \
  --pod-network-cidr 10.244.0.0/16 \
  --token ${KUBEADM_TOKEN}

## setup kubeconfig file for root user
mkdir -p $HOME/.kube
sudo cp -Rf /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

## copy kubeconfig file into vagrant user environment
mkdir /home/vagrant/.kube
sudo cp -Rf /etc/kubernetes/admin.conf /home/vagrant/.kube/config
sudo chown -R vagrant:vagrant /home/vagrant/.kube

## install calico
kubectl apply -f https://raw.githubusercontent.com/mmorejon/erase-una-vez-k8s/master/calico/calico.yaml

## enable completion commands
echo "source <(kubectl completion bash)" >> /home/vagrant/.bashrc