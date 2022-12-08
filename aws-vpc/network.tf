data "aws_availability_zones" "available" {
  state = "available"
}

# Private subnet 1 for Kubernetes cluster
resource "aws_subnet" "private_subnet_1" {
    vpc_id                  = aws_vpc.vpc.id
    map_public_ip_on_launch = false
    cidr_block              = cidrsubnet(var.vpc_cidr, 8, 240)
    availability_zone       = element(data.aws_availability_zones.available.names, 0)
    tags = {
      Name                  = "private-subnet-1-${var.vpc_name}"
    }
}

# Private subnet 2 for Kubernetes cluster
resource "aws_subnet" "private_subnet_2" {
    vpc_id                  = aws_vpc.vpc.id
    map_public_ip_on_launch = false
    cidr_block              = cidrsubnet(var.vpc_cidr, 8, 242)
    availability_zone       = element(data.aws_availability_zones.available.names, 1)
    tags = {
      Name                  = "private-subnet-2-${var.vpc_name}"
    }
}

# Public subnet 1
resource "aws_subnet" "public_subnet_1" {
    vpc_id                  = aws_vpc.vpc.id
    map_public_ip_on_launch = true
    cidr_block              = cidrsubnet(var.vpc_cidr, 8, 245)
    availability_zone       = element(data.aws_availability_zones.available.names, 0)
    tags = {
      Name                  = "public-subnet-1-${var.vpc_name}"
    }
}

# Public subnet 2
resource "aws_subnet" "public_subnet_2" {
    vpc_id                  = aws_vpc.vpc.id
    map_public_ip_on_launch = true
    cidr_block              = cidrsubnet(var.vpc_cidr, 8, 246)
    availability_zone       = element(data.aws_availability_zones.available.names, 1)
    tags = {
      Name                  = "public-subnet-2-${var.vpc_name}"
    }
}

# Public route table
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name                  = "public-route-${var.vpc_name}"
  }
}

# Private route table
resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name                  = "private-route-${var.vpc_name}"
  }
}

# Create route table association for public route table for public sub 1
resource "aws_route_table_association" "public_rt_association_1" {
  subnet_id = aws_subnet.public_subnet_1.id
  route_table_id = aws_route_table.public_route_table.id
}

# Create route table association for public route table for public sub 2
resource "aws_route_table_association" "public_rt_association_2" {
  subnet_id = aws_subnet.public_subnet_2.id
  route_table_id = aws_route_table.public_route_table.id
}

# Create route table association for private route table for private sub 1
resource "aws_route_table_association" "private_rt_association_1" {
  subnet_id = aws_subnet.private_subnet_1.id
  route_table_id = aws_route_table.private_route_table.id
}

# Create route table association for private route table for private sub 2
resource "aws_route_table_association" "private_rt_association_2" {
  subnet_id = aws_subnet.private_subnet_2.id
  route_table_id = aws_route_table.private_route_table.id
}