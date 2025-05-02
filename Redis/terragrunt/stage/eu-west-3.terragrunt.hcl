terraform {
  source = "git::https://github.com/your-org/your-repo.git//modules/redis?ref=v1.0"
}

inputs = {
  provider                      = "aws.stage"
  environment                   = "stage"
  subnet_group_name             = "redis-subnet-group-eu-west-3"
  subnet_ids                    = ["subnet-0abc1234def567890", "subnet-0def1234abc567890"]
  vpc_id                        = "vpc-0def1234abc567890"
  allowed_cidr                  = "10.30.0.0/16"
  replication_group_id          = "redis-stage-eu-west-3"
  replication_group_description = "Redis cluster for stage in eu-west-3"
  engine_version                = "6.x"
  node_type                     = "cache.t3.small"
  number_of_cache_clusters      = 2
  automatic_failover_enabled    = true
  preferred_cache_cluster_azs   = ["eu-west-3a", "eu-west-3b"]
  snapshot_retention_limit      = 5
  snapshot_window               = "06:00-07:00"
  global_replication_group_id   = null
}

