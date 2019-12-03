#!/usr/bin/env bash

# add nodes to kubernetes cluster
kubeadm join ${MASTER_IP}:6443 \
  --token ${KUBEADM_TOKEN} \
  --discovery-token-unsafe-skip-ca-verification