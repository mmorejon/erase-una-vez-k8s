#!/usr/bin/env bash

# add nodes to kubernetes cluster
envsubst < ${REPO_PATH}/cluster/default-node.yaml > ${REPO_PATH}/cluster/node.yaml
kubeadm join --config ${REPO_PATH}/cluster/node.yaml
rm ${REPO_PATH}/cluster/node.yaml