terraform {
  source = "git::https://github.com/your-org/your-repo.git//modules/redis?ref=v1.0"
}

inputs = {
  provider                      = "aws.prod"
  environment                   = "prod"
  subnet_group_name             = "redis-subnet-group-eu-west-1"
  subnet_ids                    = ["subnet-0a1234567890abcd1", "subnet-0b234567890abcd12"]
  vpc_id                        = "vpc-0a1234567890abcd1"
  allowed_cidr                  = "10.0.0.0/16"
  replication_group_id          = "redis-prod-eu-west-1"
  replication_group_description = "Production Redis cluster in eu-west-1"
  engine_version                = "6.x"
  node_type                     = "cache.r6g.large"
  number_of_cache_clusters      = 3
  automatic_failover_enabled    = true
  preferred_cache_cluster_azs   = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]
  snapshot_retention_limit      = 15
  snapshot_window               = "02:00-03:00"
  global_replication_group_id   = null
}
provider "aws" {
  region = "eu-west-1"
}


provider "aws" {
  alias  = "secondary"
  region = "eu-west-2"
}
