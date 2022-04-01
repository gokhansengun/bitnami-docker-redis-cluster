#!/bin/bash -e

# on minikube
# sudo ip link set docker0 promisc on

for ((i=0;i<5;i++)); do
  helm upgrade  --install redis-node-${i} \
    --namespace=default \
    --create-namespace \
    --values helm/values/redis-node-${i}.yaml \
    helm/charts/redis-cluster-node
done

helm upgrade  --install redis-node-5 \
  --namespace=default \
  --create-namespace \
  --values helm/values/redis-node-5.yaml \
  helm/charts/redis-cluster-node
