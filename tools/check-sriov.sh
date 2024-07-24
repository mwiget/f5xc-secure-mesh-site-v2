#!/bin/bash
source env.sh
echo ""
nodes=$(kubectl get nodes | grep ' Ready ' | awk '{print $1}')
echo $nodes
for node in $nodes; do
  echo "$node ..."
  kubectl get nodes $node -o json | jq '.status.allocatable'
  echo ""
done
echo ""
echo "k get configmap -n kubesystem sriovdp-config ..."
kubectl  get configmap -n kube-system sriovdp-config -o yaml
echo ""
echo "k get daemonset -n kubesystem ..."
kubectl  get daemonset -n kube-system
echo ""
echo "k get -n kube-system get pod ..."
kubectl -n kube-system get pod
echo ""
echo "k get net-attach-def -n ves-system ..."
kubectl get net-attach-def -n ves-system 

