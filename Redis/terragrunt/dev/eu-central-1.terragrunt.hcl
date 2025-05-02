terraform {
  source = "git::https://github.com/your-org/your-repo.git//modules/redis?ref=v1.0"
}

inputs = {
  provider                        = "aws.dev"
  environment                     = "dev"
  subnet_group_name               = "redis-subnet-group-eu-central-1"
  subnet_ids                      = ["subnet-0f1abc2de34fa5b67", "subnet-0a9f8d6b1c2e3d456"]
  vpc_id                          = "vpc-0abc123def456gh78"
  allowed_cidr                    = "10.3.0.0/16"
  replication_group_id            = "redis-dev-eu-central-1"
  replication_group_description   = "Redis cluster for dev in eu-central-1"
  engine_version                  = "6.x"
  node_type                       = "cache.t3.micro"
  number_of_cache_clusters        = 1
  automatic_failover_enabled      = true
  preferred_cache_cluster_azs     = ["eu-central-1a", "eu-central-1b"]
  snapshot_retention_limit        = 3
  snapshot_window                 = "06:00-07:00"
  global_replication_group_id     = null
}
