#!/bin/bash

# clustername=$1
# store=$2
# keyname=$3

echo "$1"

export KOPS_CLUSTER_NAME="$1"
export KOPS_STATE_STORE=s3://"$2"
export Master_Count="3"
export Master_Volume_Size="50"
export Master_Instance_Type="t2.medium"
export Master_Zones="us-east-1a,us-east-1b,us-east-1c"
export Node_Zones="us-east-1a,us-east-1b,us-east-1c"
export Node_Count="3"
export Node_Size="t2.small"
export Node_Volume="20"
export Kubernetes_version="1.22.15"
export Public_Key="~/.ssh/"$3".pub"