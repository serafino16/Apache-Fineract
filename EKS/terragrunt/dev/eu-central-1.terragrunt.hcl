include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "../../../../modules/eks-cluster"
}

locals {
  environment  = "dev"
  region       = "eu-central-1"
  subnet_ids   = ["subnet-abc123dev1", "subnet-def456dev2"]
  service_ipv4_cidr = "172.31.0.0/16"
}

inputs = merge(local.common_vars, {
  environment  = local.environment
  subnet_ids   = local.subnet_ids
  service_ipv4_cidr = local.service_ipv4_cidr
})