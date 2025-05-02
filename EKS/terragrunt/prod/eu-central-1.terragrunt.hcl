include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "../../../../modules/eks-cluster"
}

locals {
  environment  = "prod"
  region       = "eu-central-1"
  subnet_ids   = ["subnet-prd9r0s1t", "subnet-prd2u3v4w"]
  service_ipv4_cidr = "172.29.3.0/16"
}

inputs = merge(local.common_vars, {
  environment  = local.environment
  subnet_ids   = local.subnet_ids
  service_ipv4_cidr = local.service_ipv4_cidr
})