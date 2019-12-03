#!/usr/bin/env bash

## initialize kubernetes cluster
kubeadm init \
  --kubernetes-version ${KUBERNETES_VERSION} \
  --apiserver-advertise-address ${MASTER_IP} \
  --pod-network-cidr 192.168.0.0/16 \
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
kubectl apply -f https://docs.projectcalico.org/v3.8/manifests/calico.yaml

## enable completion commands
echo "source <(kubectl completion bash)" >> /home/vagrant/.bashrc