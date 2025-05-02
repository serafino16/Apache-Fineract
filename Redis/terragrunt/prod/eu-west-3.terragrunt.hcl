terraform {
  source = "git::https://github.com/your-org/your-repo.git//modules/redis?ref=v1.0"
}

inputs = {
  provider                      = "aws.prod"
  environment                   = "prod"
  subnet_group_name             = "redis-subnet-group-eu-west-3"
  subnet_ids                    = ["subnet-0abc456789123def", "subnet-0bcd456789123efg"]
  vpc_id                        = "vpc-0abc456789123def"
  allowed_cidr                  = "10.2.0.0/16"
  replication_group_id          = "redis-prod-eu-west-3"
  replication_group_description = "Production Redis cluster in eu-west-3"
  engine_version                = "6.x"
  node_type                     = "cache.r6g.large"
  number_of_cache_clusters      = 3
  automatic_failover_enabled    = true
  preferred_cache_cluster_azs   = ["eu-west-3a", "eu-west-3b", "eu-west-3c"]
  snapshot_retention_limit      = 15
  snapshot_window               = "04:00-05:00"
  global_replication_group_id   = null
}
provider "aws" {
  region = "eu-west-3"
}


provider "aws" {
  alias  = "secondary"
  region = "eu-west-1"
}

