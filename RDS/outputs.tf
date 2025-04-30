output "rds_instance_endpoints" {
  description = "Endpoints of the RDS instances"
  value = {
    for k, v in aws_db_instance.rds_instance : k => v.endpoint
  }
}

output "rds_instance_ids" {
  description = "IDs of the RDS instances"
  value = {
    for k, v in aws_db_instance.rds_instance : k => v.id
  }
}

output "rds_instance_arns" {
  description = "ARNs of the RDS instances"
  value = {
    for k, v in aws_db_instance.rds_instance : k => v.arn
  }
}

output "rds_read_replica_endpoints" {
  description = "Endpoints of the RDS read replicas"
  value = {
    for k, v in aws_db_instance.rds_read_replica : k => v.endpoint
  }
}

output "rds_security_groups" {
  description = "Security Groups attached to RDS instances"
  value = {
    for k, v in aws_security_group.rds_sg : k => v.id
  }
}

output "rds_subnet_groups" {
  description = "Subnet Groups used by RDS instances"
  value = {
    for k, v in aws_db_subnet_group.rds_subnet_group : k => v.name
  }
}

output "rds_kms_keys" {
  description = "KMS keys used for RDS encryption"
  value = {
    for k, v in aws_kms_key.rds_key : k => v.arn
  }
}
output "rds_iam_role_arn" {
  description = "IAM Role ARN attached to RDS"
  value       = aws_iam_role.rds_iam_role.arn
}

output "rds_iam_role_name" {
  description = "IAM Role name attached to RDS"
  value       = aws_iam_role.rds_iam_role.name
}