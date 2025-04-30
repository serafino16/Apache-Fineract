resource "aws_elasticache_subnet_group" "redis_subnet_group" {
  provider   = var.provider
  name       = var.subnet_group_name
  subnet_ids = var.subnet_ids

  tags = {
    Name = var.subnet_group_name
    Environment = var.environment
  }
}

resource "aws_security_group" "redis_sg" {
  provider    = var.provider
  name        = "redis-security-group-${var.environment}"
  description = "Allow inbound traffic to Redis in ${var.environment} region"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 6379
    to_port     = 6379
    protocol    = "tcp"
    cidr_blocks = [var.allowed_cidr]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_elasticache_replication_group" "redis_cluster" {
  provider                     = var.provider
  replication_group_id         = var.replication_group_id
  replication_group_description = var.replication_group_description
  engine                       = "redis"
  engine_version               = var.engine_version
  node_type                    = var.node_type
  number_of_cache_clusters     = var.number_of_cache_clusters
  automatic_failover_enabled   = var.automatic_failover_enabled
  preferred_cache_cluster_azs  = var.preferred_cache_cluster_azs
  subnet_group_name            = aws_elasticache_subnet_group.redis_subnet_group.name
  security_group_ids           = [aws_security_group.redis_sg.id]
  snapshot_retention_limit     = var.snapshot_retention_limit
  snapshot_window              = var.snapshot_window

  dynamic "global_replication_group_id" {
    for_each = var.global_replication_group_id != null ? [1] : []
    content {
      global_replication_group_id = var.global_replication_group_id
    }
  }

  tags = {
    Name        = var.replication_group_id
    Environment = var.environment
  }
}

resource "aws_iam_policy" "allow_redis_access" {
  name        = "AllowRedisAccess"
  description = "Policy to allow EC2 instances to access Redis clusters in multiple regions"
  policy      = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = [
          "elasticache:DescribeCacheClusters",
          "elasticache:DescribeReplicationGroups",
          "elasticache:Connect"
        ]
        Resource = "*"
      }
    ]
  })
}


resource "aws_iam_policy" "allow_redis_snapshot_management" {
  name        = "AllowRedisSnapshotManagement"
  description = "Policy to allow management of Redis snapshots for backup purposes"
  policy      = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = [
          "elasticache:CreateSnapshot",
          "elasticache:DeleteSnapshot",
          "elasticache:DescribeSnapshots",
          "elasticache:CopySnapshot"
        ]
        Resource = "*"
      }
    ]
  })
}


resource "aws_iam_policy" "allow_redis_global_datastore_management" {
  name        = "AllowRedisGlobalDatastoreManagement"
  description = "Policy to allow management of Redis global datastores for cross-region replication"
  policy      = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = [
          "elasticache:CreateGlobalReplicationGroup",
          "elasticache:DescribeGlobalReplicationGroups",
          "elasticache:DeleteGlobalReplicationGroup",
          "elasticache:FailoverGlobalReplicationGroup"
        ]
        Resource = "*"
      }
    ]
  })
}