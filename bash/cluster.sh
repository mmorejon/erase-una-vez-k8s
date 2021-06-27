#!/bin/bash

# get all parameters
args=("$@")

# create cluster
if [[ " ${args[*]} " == *" create "* ]]; then
kind create cluster \
    --config=cluster/kind-config.yaml
fi
# delete cluster
if [[ " ${args[*]} " == *" delete "* ]]; then
kind delete cluster --name book
fi
# clean cluster
if [[ " ${args[*]} " == *" clean "* ]]; then
./bash/clean-cluster.sh
fi
