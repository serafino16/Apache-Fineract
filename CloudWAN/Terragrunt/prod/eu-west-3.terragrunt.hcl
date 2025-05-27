locals {
  region             = "eu-west-3"
  environment        = "prod"
  core_network_desc  = "Core Network for ${local.environment} in ${local.region}"
  global_network_desc = "Global Network for ${local.environment} in ${local.region}"
}

inputs = {
  description         = local.core_network_desc
  global_description  = local.global_network_desc
  tags = {
    Environment = local.environment
    Region      = local.region
    Owner       = "your-team@example.com"
  }
}
