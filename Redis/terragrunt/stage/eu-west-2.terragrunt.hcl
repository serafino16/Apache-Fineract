terraform {
  source = "git::https://github.com/your-org/your-repo.git//modules/redis?ref=v1.0"
}

inputs = {
  provider                      = "aws.stage"
  environment                   = "stage"
  subnet_group_name             = "redis-subnet-group-eu-west-2"
  subnet_ids                    = ["subnet-01a2b3c4d5e6f7g8h", "subnet-02b3c4d5e6f7g8h9i"]
  vpc_id                        = "vpc-0123456789abcdef0"
  allowed_cidr                  = "10.20.0.0/16"
  replication_group_id          = "redis-stage-eu-west-2"
  replication_group_description = "Redis cluster for stage in eu-west-2"
  engine_version                = "6.x"
  node_type                     = "cache.t3.small"
  number_of_cache_clusters      = 2
  automatic_failover_enabled    = true
  preferred_cache_cluster_azs   = ["eu-west-2a", "eu-west-2b"]
  snapshot_retention_limit      = 5
  snapshot_window               = "05:00-06:00"
  global_replication_group_id   = null
}
