output "efs_file_system_ids" {
  description = "EFS File System IDs per region"
  value = {
    for region, fs in aws_efs_file_system.efs_file_system : region => fs.id
  }
}

output "efs_security_group_ids" {
  description = "Security Group IDs per region for EFS access"
  value = {
    for region, sg in aws_security_group.efs_allow_access : region => sg.id
  }
}

output "efs_replication_configuration" {
  description = "EFS Replication Configuration ID"
  value       = aws_efs_replication_configuration.efs_replica[*].id
}
