provider "aws" {
  alias = "prod"
  region = var.region
  profile = var.profile_prod
}

provider "aws" {
  alias = "jenkins"
  region = var.region
  profile = var.profile_root
}

locals {
  account_id  = data.aws_caller_identity.current.account_id
  jenkins_account_id  = data.aws_caller_identity.jenkins.account_id
}

resource "aws_vpc_peering_connection" "vpc-peer" {
  peer_owner_id = local.account_id
  vpc_id      =  var.aws_vpc_id
  peer_vpc_id =  var.cluster_vpc_id
  auto_accept = true

  accepter {
    allow_remote_vpc_dns_resolution = true
  }
  requester {
    allow_remote_vpc_dns_resolution = true
  }

  tags = {
    Name = "vpc-peer"
    Side = "Requestor"
  }
}

# peer is kops
resource "aws_route" "vpc-peer" {
  route_table_id            = var.cluster_vpc_pvt_rt
  destination_cidr_block    = var.aws_vpc_cidr_block 
  vpc_peering_connection_id = aws_vpc_peering_connection.vpc-peer.id
  depends_on = [var.cluster_vpc_pvt_rt]
}

# RDS is the acceptor
resource "aws_route" "vpc-accepter" {
  route_table_id            = var.aws_vpc_pvt_rt
  destination_cidr_block    = var.cluster_vpc_cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.vpc-peer.id
  depends_on = [var.aws_vpc_pvt_rt]
}

# jenkins vpc_peering_connection, peer - accepter (jenkins), cluster -requester
resource "aws_vpc_peering_connection" "cluster-peer" {
  peer_owner_id = local.jenkins_account_id
  vpc_id        =  var.cluster_vpc_id
  peer_vpc_id   =  var.jenkins_vpc
  tags = {
    Name = "jenkins-peer-to-accepter"
    Side = "Requestor"
  }
}

resource "aws_vpc_peering_connection_accepter" "jenkins-accepter" {
  provider                  = aws.jenkins
  vpc_peering_connection_id = aws_vpc_peering_connection.cluster-peer.id
  auto_accept               = true
}

resource "aws_route" "peer-owner" {
  route_table_id            = var.cluster_vpc_pvt_rt
  destination_cidr_block    = var.jenkins_cidr 
  vpc_peering_connection_id = aws_vpc_peering_connection.cluster-peer.id
  depends_on = [var.cluster_vpc_pvt_rt]
}

resource "aws_route" "peer-acceptor" {
  provider                  = aws.jenkins
  route_table_id            = var.jenkins_rt
  destination_cidr_block    = var.cluster_vpc_cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.cluster-peer.id
}