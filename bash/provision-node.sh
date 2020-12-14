#!/usr/bin/env bash

# add nodes to kubernetes cluster
# kubeadm join ${MASTER_IP}:6443 \
#   --token ${KUBEADM_TOKEN} \
#   --discovery-token-unsafe-skip-ca-verification

envsubst < ${REPO_PATH}/cluster/default-node.yaml > ${REPO_PATH}/cluster/node.yaml
kubeadm join --config ${REPO_PATH}/cluster/node.yaml
rm ${REPO_PATH}/cluster/node.yaml