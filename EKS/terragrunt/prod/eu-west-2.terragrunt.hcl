include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "../../../../modules/eks-cluster"
}

locals {
  environment  = "prod"
  region       = "eu-west-2"
  subnet_ids   = ["subnet-prd7g8h9i", "subnet-prd0j1k2l"]
  service_ipv4_cidr = "172.29.1.0/16"
}

inputs = merge(local.common_vars, {
  environment  = local.environment
  subnet_ids   = local.subnet_ids
  service_ipv4_cidr = local.service_ipv4_cidr
})