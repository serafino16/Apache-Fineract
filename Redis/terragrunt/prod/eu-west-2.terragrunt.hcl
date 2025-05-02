terraform {
  source = "git::https://github.com/your-org/your-repo.git//modules/redis?ref=v1.0"
}

inputs = {
  provider                      = "aws.prod"
  environment                   = "prod"
  subnet_group_name             = "redis-subnet-group-eu-west-2"
  subnet_ids                    = ["subnet-0123abcd4567efgh", "subnet-0456abcd1234efgh"]
  vpc_id                        = "vpc-0456abcd1234efgh"
  allowed_cidr                  = "10.1.0.0/16"
  replication_group_id          = "redis-prod-eu-west-2"
  replication_group_description = "Production Redis cluster in eu-west-2"
  engine_version                = "6.x"
  node_type                     = "cache.r6g.large"
  number_of_cache_clusters      = 3
  automatic_failover_enabled    = true
  preferred_cache_cluster_azs   = ["eu-west-2a", "eu-west-2b", "eu-west-2c"]
  snapshot_retention_limit      = 15
  snapshot_window               = "03:00-04:00"
  global_replication_group_id   = null
}
provider "aws" {
  region = "eu-west-2"
}


provider "aws" {
  alias  = "secondary"
  region = "eu-west-1"
}
