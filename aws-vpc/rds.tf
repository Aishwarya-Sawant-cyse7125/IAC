# IAM user permission
data "aws_iam_policy_document" "rds_kms_policy_document" {
  statement {
    sid       = "rdskey"
    actions   = ["kms:*"]
    resources = ["*"]
    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${local.account_id}:root"]
    }
  }
}

resource "aws_db_subnet_group" "rds_db_subnet_group" {
  name       = "rds-db-subnet-group"
  subnet_ids = [aws_subnet.private_subnet_1.id, aws_subnet.private_subnet_2.id]
  tags = {
    Name = "RDS_DB_Subnet_Group"
  }
}

resource "aws_db_parameter_group" "rds_parameter_group" {
  name   = "rds-parameter-group"
  family = "postgres13"
  parameter {
    name  = "log_connections"
    value = 1
  }
  parameter {
    name  = "rds.force_ssl"
    value = 0
  }
}

resource "aws_kms_key" "rds_kms_key" {
  description             = "Customer managed RDS key"
  deletion_window_in_days = 7
  is_enabled              = true
  policy                  = data.aws_iam_policy_document.rds_kms_policy_document.json
  tags = {
    Name                  = "rds-ebs-key"
  }
}

resource "aws_db_instance" "rds_db_instance" {
  allocated_storage       = 20
  # storage_type            = "gp2"
  db_name                 = "csye7125"
  engine                  = "postgres"
  engine_version          = "13.4"
  instance_class          = "db.t3.micro"
  username                = "csye7125"
  password                = "db22csye7125"
  # multi_az                = false
  identifier              = "csye7125"
  db_subnet_group_name    = aws_db_subnet_group.rds_db_subnet_group.id
  # publicly_accessible     = false
  # parameter_group_name    = aws_db_parameter_group.rds_parameter_group.id
  vpc_security_group_ids  = ["${aws_security_group.db_security_group.id}"]
  skip_final_snapshot     = true
  # storage_encrypted       = true
  # kms_key_id              = aws_kms_key.rds_kms_key.arn
}