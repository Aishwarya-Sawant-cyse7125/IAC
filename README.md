# VPC Peering between KUBERNETES CLUSTER-VPC and RDS AWS-VPC ON AWS using TERRAFORM

## Prequisite
- Install [Kops](https://github.com/kubernetes/kops/blob/master/docs/install.md)
- Install [KubeCtl](https://kubernetes.io/docs/tasks/tools/install-kubectl-binary-using-native-package-management)
- Install [aws cli](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-getting-started.html)
- Install [Terraform](https://learn.hashicorp.com/tutorials/terraform/install-cli)



## KOPS ARGUMENTS :
```bash
Kubernetes Version : "1.22.15"
Master node size : "t2.medium"
Master node count : 3
Compute node size : "t2.small"
Compute node count : 3
DNS Zone : aws.yourdomainname.me
Master Availability Zones : "us-east-1a,us-east-1b,us-east-1c"
Node Availability Zones : "us-east-1a,us-east-1b,us-east-1c"
KOPS Cluster Name : <clustername>
KOPS STATE STORE : s3://yourbucketname
SSH Key : "~/.ssh/<yourkey.pub>"
``` 


## Create Cluster Terraform File Command
``` bash
    kops create cluster \
    --zones=$Node_Zones \
    --name=${KOPS_CLUSTER_NAME} \
    --node-count=$Node_Count \
    --node-size=$Node_Size \
    --node-volume-size=$Node_Volume \
    --master-size=$Master_Instance_Type
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
    --out=. \
    --target=terraform
```

## The IAC Folder structure is as follows,
-  AWS-VPC directory has all your Terraform Files required to create and deploy RDS.
-  Cluster-VPC directory has your previously created Kubernets.tf file to deploy Kubernetes Cluster.
-  VPC-Peering directory has all your files required to perform VPC Peering between AWS-VPC & CLUSTER-VPC.

```
   IAC
   ├─ aws-vpc
   │  ├─ data.tf
   │  ├─ locals.tf
   │  ├─ main.tf
   │  ├─ network.tf
   │  ├─ output.tf
   │  ├─ rds.tf
   │  ├─ security_groups.tf
   │  ├─ variables.tf
   │  └─ vpc.tf
   ├─ cluster-vpc
   │  ├─ data
   │  └─ kubernetes.tf
   ├─ main.tf
   ├─ output.tf
   ├─ README.md
   ├─ terraform.tfstate
   └─ vpc-peering
      ├─ data.tf
      ├─ main.tf
      └─ variables.tf
```

## Run Follwing Terraform Commands to Initialize, Plan and Apply VPC-PEERING on AWS

```bash
terraform init
```

```bash
terraform plan
```

```bash
terraform apply
```
