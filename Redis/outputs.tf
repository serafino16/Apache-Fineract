output "redis_replication_group_id" {
  description = "The ID of the Redis replication group"
  value       = aws_elasticache_replication_group.redis_cluster.id
}

output "redis_primary_endpoint_address" {
  description = "The address of the Redis primary endpoint"
  value       = aws_elasticache_replication_group.redis_cluster.primary_endpoint_address
}

output "redis_reader_endpoint_address" {
  description = "The address of the Redis reader endpoint"
  value       = aws_elasticache_replication_group.redis_cluster.reader_endpoint_address
}

output "security_group_id" {
  description = "The ID of the Redis security group"
  value       = aws_security_group.redis_sg.id
}

output "subnet_group_name" {
  description = "The name of the Redis subnet group"
  value       = aws_elasticache_subnet_group.redis_subnet_group.name
}
output "redis_iam_policies" {
  description = "List of Redis-related IAM policies created"
  value = [
    aws_iam_policy.allow_redis_access.arn,
    aws_iam_policy.allow_redis_snapshot_management.arn,
    aws_iam_policy.allow_redis_global_datastore_management.arn
  ]
}