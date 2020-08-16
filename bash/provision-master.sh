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

curl -fsSL -o ke.tar.gz https://kubexercises.s3-eu-west-1.amazonaws.com/v0.3.0/ke_0.3.0_linux_amd64.tar.gz
tar -zxf ke.tar.gz
mv ke /usr/local/bin/ke
rm ke.tar.gz

## start load balance
docker container run --rm \
  --detach \
  -v /home/vagrant/erase-una-vez-k8s/lb/envoy.yaml:/etc/envoy/envoy.yaml \
  -p 80:80 \
  -p 443:443 \
  envoyproxy/envoy-alpine:v1.13.0 > /dev/null 2>&1

## Replaces line endings
echo "sed -i -e 's/\r$//' /home/vagrant/erase-una-vez-k8s/bash/clean-cluster.sh" >> /home/vagrant/.bashrc
echo "sed -i -e 's/\r$//' /home/vagrant/erase-una-vez-k8s/bash/create-user.sh" >> /home/vagrant/.bashrc

## create alias to clean the cluster
echo "alias clean-cluster=/home/vagrant/erase-una-vez-k8s/bash/clean-cluster.sh" >> /home/vagrant/.bashrc
## create alias to generate user configurations
echo "alias create-user=/home/vagrant/erase-una-vez-k8s/bash/create-user.sh" >> /home/vagrant/.bashrc

## remove RANDFILE configuration for openssl to avoid a warning message
## https://github.com/openssl/openssl/issues/7754
sed -i "s/RANDFILE\s*=\s*\$ENV::HOME\/\.rnd/#/" /etc/ssl/openssl.cnf