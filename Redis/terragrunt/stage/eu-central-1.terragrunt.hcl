terraform {
  source = "git::https://github.com/your-org/your-repo.git//modules/redis?ref=v1.0"
}

inputs = {
  provider                      = "aws.stage"
  environment                   = "stage"
  subnet_group_name             = "redis-subnet-group-eu-central-1"
  subnet_ids                    = ["subnet-0123abcd4567efgh", "subnet-0abcd1234efgh5678"]
  vpc_id                        = "vpc-0123abcd4567efgh"
  allowed_cidr                  = "10.40.0.0/16"
  replication_group_id          = "redis-stage-eu-central-1"
  replication_group_description = "Redis cluster for stage in eu-central-1"
  engine_version                = "6.x"
  node_type                     = "cache.t3.small"
  number_of_cache_clusters      = 2
  automatic_failover_enabled    = true
  preferred_cache_cluster_azs   = ["eu-central-1a", "eu-central-1b"]
  snapshot_retention_limit      = 5
  snapshot_window               = "07:00-08:00"
  global_replication_group_id   = null
}
