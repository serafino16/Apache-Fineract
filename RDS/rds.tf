resource "aws_kms_key" "rds_key" {
  for_each    = toset(var.regions)
  description = "RDS KMS key for encryption in ${each.key}"
}

resource "aws_security_group" "rds_sg" {
  for_each    = toset(var.regions)
  name        = "rds-security-group-${each.key}"
  description = "Security group for RDS in ${each.key}"
  vpc_id      = data.terraform_remote_state.eks[each.key].outputs.vpc_id

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = [data.terraform_remote_state.eks[each.key].outputs.vpc_cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_db_subnet_group" "rds_subnet_group" {
  for_each   = toset(var.regions)
  name       = "rds-subnet-group-${each.key}"
  subnet_ids = data.terraform_remote_state.eks[each.key].outputs.private_subnets

  tags = {
    Name = "RDS Subnet Group - ${each.key}"
  }
}

resource "aws_db_parameter_group" "rds_parameter_group" {
  for_each    = toset(var.regions)
  name        = "custom-rds-parameter-group-${each.key}"
  family      = "postgres14"
  description = "Custom parameter group for RDS in ${each.key}"

  parameter {
    name  = "max_connections"
    value = "500"
  }

  parameter {
    name  = "query_cache_size"
    value = "256MB"
  }
}

resource "aws_db_instance" "rds_instance" {
  for_each                = toset(var.regions)
  identifier              = "rds-fineract-${each.key}"
  engine                  = "postgres"
  engine_version          = "14.4"
  instance_class          = "db.m5.large"
  allocated_storage       = 100
  max_allocated_storage   = 200
  storage_encrypted       = true
  kms_key_id              = aws_kms_key.rds_key[each.key].key_id
  db_subnet_group_name    = aws_db_subnet_group.rds_subnet_group[each.key].name
  vpc_security_group_ids  = [aws_security_group.rds_sg[each.key].id]
  multi_az                = contains(["eu-west-1", "eu-west-2"], each.key)
  publicly_accessible     = false
  backup_retention_period = 7
  preferred_backup_window = "07:00-09:00"
  preferred_maintenance_window = "sun:05:00-sun:06:00"
  auto_minor_version_upgrade   = true
  db_parameter_group_name      = aws_db_parameter_group.rds_parameter_group[each.key].name
  iam_database_authentication_enabled = true

  tags = {
    Name        = "RDS Fineract ${each.key}"
    Environment = each.key == "eu-west-1" ? "prod" : each.key == "eu-west-2" ? "stage" : "prod"
  }
}

resource "aws_db_instance" "rds_read_replica" {
  for_each            = toset(var.read_replica_regions)
  replicate_source_db = aws_db_instance.rds_instance["eu-west-1"].id
  instance_class      = "db.m5.large"
  availability_zone   = "${each.key}a"
  skip_final_snapshot = true

  tags = {
    Name = "rds-replica-${each.key}"
    Environment = "prodbackup"
  }
}

resource "aws_backup_plan" "prod_backup_plan" {
  name = "prod-backup-plan"

  rule {
    rule_name         = "prod-backup-rule"
    target_vault_name = var.backup_vault_name
    schedule          = "cron(0 3 ? * 7 *)"

    lifecycle {
      delete {
        days = 30
      }
    }
  }
}

resource "aws_backup_selection" "prod_backup_selection" {
  plan_id        = aws_backup_plan.prod_backup_plan.id
  resources      = [aws_db_instance.rds_instance["eu-west-1"].arn]
  iam_role_arn   = var.backup_iam_role_arn
}
resource "aws_iam_role" "rds_iam_role" {
  name               = var.iam_role_name
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action    = "sts:AssumeRole"
        Principal = {
          Service = "rds.amazonaws.com"
        }
        Effect    = "Allow"
        Sid       = ""
      }
    ]
  })
}

resource "aws_iam_policy_attachment" "rds_iam_policy_attachment" {
  name       = "rds-iam-policy-attachment"
  policy_arn = "arn:aws:iam::aws:policy/AmazonRDSDataFullAccess"
  roles      = [aws_iam_role.rds_iam_role.name]
}