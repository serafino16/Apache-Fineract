include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "../../../../modules/eks-cluster"
}

locals {
  environment  = "stage"
  region       = "eu-central-1"
  subnet_ids   = ["subnet-stg9r0s1t", "subnet-stg2u3v4w"]
  service_ipv4_cidr = "172.30.3.0/16"
}

inputs = merge(local.common_vars, {
  environment  = local.environment
  subnet_ids   = local.subnet_ids
  service_ipv4_cidr = local.service_ipv4_cidr
})