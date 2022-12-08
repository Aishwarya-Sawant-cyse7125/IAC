resource "aws_security_group" "db_security_group" {
  name        = "${var.vpc_name}-rds-sg"
  description = "RDS Security Group"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    description      = "Database Security Group"
    from_port        = 5432
    to_port          = 5432
    protocol         = "tcp"
    cidr_blocks      = [aws_vpc.vpc.cidr_block]
  }


  ingress {
    description      = "Database Security Group"
    from_port        = 5432
    to_port          = 5432
    protocol         = "tcp"
    cidr_blocks      = [var.cluster_vpc_cidr_block]
  }

  tags = {
    Name = "${var.vpc_name}-rds-sg"
  }
}
