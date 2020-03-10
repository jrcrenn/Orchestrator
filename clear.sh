#!/bin/bash

kubectl --namespace=default delete service --all

kubectl --namespace=default delete deployments.apps --all

kubectl --namespace=kube-system delete daemonsets.apps cadvisor

kubectl --namespace=kube-public delete deployments.apps traefik

kubectl --namespace=kube-public delete service traefik-service

kubectl delete ingress --all

kubectl delete  persistentvolumeclaims postgres-pv-claim

kubectl delete  persistentvolume postgres-volume

#kubectl delete configmaps redis-config
#kubectl delete configmaps postgres-config

#kubectl delete secrets postgres-secret

#clear