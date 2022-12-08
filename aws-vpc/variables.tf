variable "vpc_cidr" {
  type      = string
}
variable "vpc_name" {
  type      = string
  default = "aws-vpc"
}

#change
variable "cluster_vpc_cidr_block" {
  type = string
}

variable "region" {
  type      = string
  default   = "us-east-1"
}

variable "cluster_vpc_id" {
  type = string
}

variable "profile_prod" {
  type      = string
  default   = "prod"
}

variable "profile_root" {
  type      = string
  default   = "root"
}