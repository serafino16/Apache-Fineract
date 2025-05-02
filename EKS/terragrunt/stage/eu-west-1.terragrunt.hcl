include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "../../../../modules/eks-cluster"
}

locals {
  environment  = "stage"
  region       = "eu-west-1"
  subnet_ids   = ["subnet-stg1a2b3c", "subnet-stg4d5e6f"]
  service_ipv4_cidr = "172.30.0.0/16"
}

inputs = merge(local.common_vars, {
  environment  = local.environment
  subnet_ids   = local.subnet_ids
  service_ipv4_cidr = local.service_ipv4_cidr
})