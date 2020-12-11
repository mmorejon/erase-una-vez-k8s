#!/usr/bin/env bash

## initialize kubernetes cluster
envsubst < ${REPO_PATH}/cluster/default-master.yaml > ${REPO_PATH}/cluster/master.yaml
kubeadm init --config ${REPO_PATH}/cluster/master.yaml
rm ${REPO_PATH}/cluster/master.yaml

## setup kubeconfig file for root user
mkdir -p $HOME/.kube
sudo cp -Rf /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

## copy kubeconfig file into vagrant user environment
mkdir /home/vagrant/.kube
sudo cp -Rf /etc/kubernetes/admin.conf /home/vagrant/.kube/config
sudo chown -R vagrant:vagrant /home/vagrant/.kube

## install calico
kubectl apply -f https://raw.githubusercontent.com/mmorejon/erase-una-vez-k8s/main/calico/calico.yaml

## enable completion commands
echo "source <(kubectl completion bash)" >> /home/vagrant/.bashrc

## setup kubexercises
curl -fsSL -o ke.tar.gz https://kubexercises.s3-eu-west-1.amazonaws.com/v0.3.1/ke_0.3.1_linux_amd64.tar.gz
tar -zxf ke.tar.gz
mv ke /usr/local/bin/ke
rm ke.tar.gz

## Replaces line endings
echo "sed -i -e 's/\r$//' ${REPO_PATH}/bash/clean-cluster.sh" >> /home/vagrant/.bashrc
echo "sed -i -e 's/\r$//' ${REPO_PATH}/bash/create-user.sh" >> /home/vagrant/.bashrc

## create alias to clean the cluster
echo "alias clean-cluster=${REPO_PATH}/bash/clean-cluster.sh" >> /home/vagrant/.bashrc
## create alias to generate user configurations
echo "alias create-user=${REPO_PATH}/bash/create-user.sh" >> /home/vagrant/.bashrc

## remove RANDFILE configuration for openssl to avoid a warning message
## https://github.com/openssl/openssl/issues/7754
sed -i "s/RANDFILE\s*=\s*\$ENV::HOME\/\.rnd/#/" /etc/ssl/openssl.cnf
