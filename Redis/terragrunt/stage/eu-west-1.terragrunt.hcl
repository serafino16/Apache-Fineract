terraform {
  source = "git::https://github.com/your-org/your-repo.git//modules/redis?ref=v1.0"
}

inputs = {
  provider                      = "aws.stage"
  environment                   = "stage"
  subnet_group_name             = "redis-subnet-group-eu-west-1"
  subnet_ids                    = ["subnet-0a1b2c3d4e5f6g7h8", "subnet-0b2c3d4e5f6g7h8i9"]
  vpc_id                        = "vpc-0a1b2c3d4e5f6g7h8"
  allowed_cidr                  = "10.10.0.0/16"
  replication_group_id          = "redis-stage-eu-west-1"
  replication_group_description = "Redis cluster for stage in eu-west-1"
  engine_version                = "6.x"
  node_type                     = "cache.t3.small"
  number_of_cache_clusters      = 2
  automatic_failover_enabled    = true
  preferred_cache_cluster_azs   = ["eu-west-1a", "eu-west-1b"]
  snapshot_retention_limit      = 5
  snapshot_window               = "04:00-05:00"
  global_replication_group_id   = null
}
