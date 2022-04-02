#!/bin/bash -e

# on minikube
# sudo ip link set docker0 promisc on

announceIP=192.168.59.121
dataNodePortStart=30002
redisNodeStr=""

for ((i=0;i<=5;++i)); do
  redisNodeStr="${redisNodeStr}${announceIP}:$((${dataNodePortStart} + ${i})) "
done

for ((i=0;i<=5;i++)); do
  helm upgrade --install redis-node-${i} \
    --namespace=default \
    --create-namespace \
    --set=dataNodePort=$((${dataNodePortStart} + ${i})) \
    --set=announceIP=${announceIP} \
    --set=redisNodes="${redisNodeStr}" \
    helm/charts/redis-cluster-node
done

for ((i=0;i<=5;i++)); do
  helm upgrade --install redis-node-${i} \
    --namespace=default \
    --create-namespace \
    --set=dataNodePort=$((${dataNodePortStart} + ${i})) \
    --set=announceIP=${announceIP} \
    --set=redisNodes="${redisNodeStr}" \
    --set=reservePortsOnly=false \
    helm/charts/redis-cluster-node
done
