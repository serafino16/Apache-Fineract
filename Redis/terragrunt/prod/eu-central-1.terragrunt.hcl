terraform {
  source = "git::https://github.com/your-org/your-repo.git//modules/redis?ref=v1.0"
}

inputs = {
  provider                      = "aws.prod"
  environment                   = "prod"
  subnet_group_name             = "redis-subnet-group-eu-central-1"
  subnet_ids                    = ["subnet-0aaa111bbb222ccc3", "subnet-0bbb222ccc333ddd4"]
  vpc_id                        = "vpc-0aaa111bbb222ccc3"
  allowed_cidr                  = "10.3.0.0/16"
  replication_group_id          = "redis-prod-eu-central-1"
  replication_group_description = "Production Redis cluster in eu-central-1"
  engine_version                = "6.x"
  node_type                     = "cache.r6g.large"
  number_of_cache_clusters      = 3
  automatic_failover_enabled    = true
  preferred_cache_cluster_azs   = ["eu-central-1a", "eu-central-1b", "eu-central-1c"]
  snapshot_retention_limit      = 15
  snapshot_window               = "05:00-06:00"
  global_replication_group_id   = null
}
provider "aws" {
  region = "eu-central-1"
}


provider "aws" {
  alias  = "secondary"
  region = "eu-west-1"
}


