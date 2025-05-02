include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "../../../../modules/eks-cluster"
}

locals {
  environment  = "prod"
  region       = "eu-west-3"
  subnet_ids   = ["subnet-prd3m4n5o", "subnet-prd6p7q8r"]
  service_ipv4_cidr = "172.29.2.0/16"
}

inputs = merge(local.common_vars, {
  environment  = local.environment
  subnet_ids   = local.subnet_ids
  service_ipv4_cidr = local.service_ipv4_cidr
})