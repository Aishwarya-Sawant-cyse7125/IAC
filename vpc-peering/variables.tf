variable "cluster_vpc_id" {
  type = string
}

variable "aws_vpc_id" {
  type = string
}


variable "cluster_vpc_cidr_block" {
  type = string
}

variable "aws_vpc_cidr_block" {
  type = string
}

variable "cluster_vpc_pvt_rt" {
  type = string
}

#variable "peer_vpc_id" {
#  type        = string
#  description = "VPC ID's for Peer Acceptor Accounts"
#}

variable "profile_prod" {
  type      = string
  default   = "prod"
}

variable "profile_root" {
  type      = string
  default   = "root"
}

variable "region" {
  type      = string
  default   = "us-east-1"
}

variable "aws_vpc_pvt_rt" {
  type = string
}

variable "jenkins_vpc" {
  type = string
}

variable "jenkins_cidr" {
  type = string
}

variable "jenkins_rt" {
  type = string
}
