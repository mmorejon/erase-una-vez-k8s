#!/bin/bash

# general values
#BASEDIR='/home/vagrant/erase-una-vez-k8s'
BASEDIR=$(PWD)
COMMON_FLAGS='--ignore-not-found=true'

printf 'Iniciando el proceso de limpieza en el cluster ... \n'

# clean environment values
unset KUBECONFIG

# clean objets from chapter pods
kubectl --namespace default delete -f $BASEDIR/pods/ $COMMON_FLAGS
kubectl --namespace default delete -f $BASEDIR/labels/ $COMMON_FLAGS
kubectl --namespace default delete -f $BASEDIR/replicasets/ $COMMON_FLAGS
kubectl --namespace default delete -f $BASEDIR/deployments/ $COMMON_FLAGS
kubectl --namespace default delete -f $BASEDIR/services/ $COMMON_FLAGS
kubectl --namespace default delete -f $BASEDIR/ingress/ $COMMON_FLAGS
kubectl delete namespace ingress-nginx $COMMON_FLAGS
kubectl delete -f $BASEDIR/namespaces/ $COMMON_FLAGS
kubectl delete -f $BASEDIR/volumes/ $COMMON_FLAGS
kubectl --namespace default delete -f $BASEDIR/configmaps/ $COMMON_FLAGS
kubectl --namespace default delete -f $BASEDIR/secrets/ $COMMON_FLAGS
rm -f $BASEDIR/secrets/tls.*
kubectl delete -f $BASEDIR/rbac/ $COMMON_FLAGS
rm -f $BASEDIR/rbac/mmorejon*
rm -f $BASEDIR/rbac/ca*
kubectl --namespace default delete -f $BASEDIR/hpa/ $COMMON_FLAGS
kubectl delete -f $BASEDIR/metrics-server/ $COMMON_FLAGS

printf '\nHa terminado el proceso de limpieza en el cluster.\n'
