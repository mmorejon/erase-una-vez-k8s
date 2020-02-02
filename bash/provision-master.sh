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

## setup kubexercises
curl -fsSL -o kubexercises.tar.gz https://kubexercises.s3-eu-west-1.amazonaws.com/v0.1.1/kubexercises_0.1.1_linux_amd64.tar.gz
tar -zxf kubexercises.tar.gz
mv kubexercises /usr/local/bin/kubexercises
rm kubexercises.tar.gz

## start load balance
docker container run --rm \
  --detach \
  -v /home/vagrant/erase-una-vez-k8s/lb/envoy.yaml:/etc/envoy/envoy.yaml \
  -p 80:80 \
  -p 443:443 \
  envoyproxy/envoy-alpine:v1.13.0 > /dev/null 2>&1