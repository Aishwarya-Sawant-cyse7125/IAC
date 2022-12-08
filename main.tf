# provider "aws" {
#   region    = var.region
#   profile   = var.profile
# }

# terraform {
#   backend "kubernetes-s3" {
#     bucket  = "kb"
#     key     = "default.tfstate"
#     region  = "us-east-1"
#   }
# }

module "cluster-vpc" {
  source            = "./cluster-vpc"
}

module "aws-vpc" {
  source                        = "./aws-vpc"
  vpc_cidr                      = "150.0.0.0/16"
  vpc_name                      = "aws-vpc"
  cluster_vpc_id                = module.cluster-vpc.vpc_id
  cluster_vpc_cidr_block        = module.cluster-vpc.vpc_cidr_block
}

module "vpc-peering" {
  source                    = "./vpc-peering"
  cluster_vpc_id            = module.cluster-vpc.vpc_id
  cluster_vpc_cidr_block    = module.cluster-vpc.vpc_cidr_block
  aws_vpc_id                = module.aws-vpc.vpc_id
  aws_vpc_cidr_block        = module.aws-vpc.vpc_cidr_block
  cluster_vpc_pvt_rt        = module.cluster-vpc.route_table_private-us-east-1a_id
  aws_vpc_pvt_rt            = module.aws-vpc.aws_vpc_pvt_rt
  jenkins_vpc               = var.jenkins_vpc
  jenkins_cidr              = var.jenkins_cidr
  jenkins_rt                = var.jenkins_rt
}