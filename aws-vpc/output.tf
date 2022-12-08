output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "vpc_cidr_block" {
  value = aws_vpc.vpc.cidr_block
}

output "aws_vpc_pvt_rt" {
  value = aws_route_table.private_route_table.id
}