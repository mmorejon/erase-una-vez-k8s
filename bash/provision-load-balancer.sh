#!/usr/bin/env bash

# start load balance
docker container run --restart unless-stopped \
  --detach \
  -v /home/vagrant/erase-una-vez-k8s/lb/envoy.yaml:/etc/envoy/envoy.yaml \
  -p 80:80 \
  -p 443:443 \
  envoyproxy/envoy-alpine:v1.13.0 > /dev/null 2>&1