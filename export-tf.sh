#!/bin/bash

set -e

kops create cluster \
--zones=$Node_Zones \
--name=${KOPS_CLUSTER_NAME} \
--node-count=$Node_Count \
--node-size=$Node_Size \
--node-volume-size=$Node_Volume \
--master-size=$Master_Instance_Type \
--master-count=$Master_Count \
--master-volume-size=$Master_Volume_Size \
--master-zones=$Master_Zones \
--ssh-public-key=$Public_Key \
--kubernetes-version=$Kubernetes_version \
--authorization=alwaysAllow \
--cloud=aws \
--dns-zone=${KOPS_CLUSTER_NAME} \
--associate-public-ip=false \
--topology=private \
--networking=calico \
--image=ami-08c40ec9ead489470 \
--bastion=true \
--out=./cluster-vpc \
--target=terraform

