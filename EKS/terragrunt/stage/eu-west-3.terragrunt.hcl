include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "../../../../modules/eks-cluster"
}

locals {
  environment  = "stage"
  region       = "eu-west-3"
  subnet_ids   = ["subnet-stg3m4n5o", "subnet-stg6p7q8r"]
  service_ipv4_cidr = "172.30.2.0/16"
}

inputs = merge(local.common_vars, {
  environment  = local.environment
  subnet_ids   = local.subnet_ids
  service_ipv4_cidr = local.service_ipv4_cidr
})