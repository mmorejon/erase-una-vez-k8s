#!/bin/bash

# get all parameters
args=("$@")

# create cluster
if [[ " ${args[*]} " == *" create "* ]]; then
kind create cluster \
    --config=cluster/kind-config.yaml
fi
# cluster multi-region
if [[ " ${args[*]} " == *" create-multi-region "* ]]; then
kind create cluster \
    --config=cluster/multi-region.yaml
fi
# delete cluster
if [[ " ${args[*]} " == *" delete "* ]]; then
kind delete cluster --name book
fi
# restart cluster
if [[ " ${args[*]} " == *" restart "* ]]; then
./bash/cluster.sh delete
./bash/cluster.sh create
fi
# restart cluster multi-region
if [[ " ${args[*]} " == *" restart-multi-region "* ]]; then
./bash/cluster.sh delete
./bash/cluster.sh create-multi-region
fi
# clean cluster
if [[ " ${args[*]} " == *" clean "* ]]; then
./bash/clean-cluster.sh
fi
