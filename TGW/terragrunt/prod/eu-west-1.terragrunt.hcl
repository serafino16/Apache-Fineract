# Directory: live/prod/eu-west-1/tgw/terragrunt.hcl


locals {
  region      = "eu-west-1"
  environment = "prod"
}

include {
  path = find_in_parent_folders()
}

terraform {
  source = "../../modules/tgw"
}

inputs = {
  description                     = "TGW for ${local.environment} in ${local.region}"
  amazon_side_asn                = 64528
  auto_accept                    = "enable"
  default_route_table_association = "enable"
  default_route_table_propagation = "enable"
  dns_support                    = "enable"
  vpn_ecmp_support               = "enable"
  create_route_table             = true
  create_associations            = true
  create_propagations           = true
  tags = {
    Environment = local.environment
    Region      = local.region
    Owner       = "networking-team"
  }
  vpc_attachments = {
    core-prod-vpc = {
      vpc_id     = "vpc-ec1prod1234abcd"
      subnet_ids = ["subnet-ec1prodsub1", "subnet-ec1prodsub2"]
      appliance_mode_support = "disable"
      dns_support  = "enable"
      ipv6_support = "disable"
      tags = {
        Name = "core-prod-vpc-tgw-attachment"
      }
    }
  }
  peering_attachments = {
    west1-peer = {
      peer_account_id = "112233445566"
      peer_region     = "eu-west-1"
      peer_tgw_id     = "tgw-west1prod001"
      tags = {
        Name = "peer-to-eu-central-1-prod"
      }
    }
    west2-peer = {
      peer_account_id = "112233445566"
      peer_region     = "eu-west-2"
      peer_tgw_id     = "tgw-west2prod001"
      tags = {
        Name = "peer-to-west2-prod"
      }
    }
    west3-peer = {
      peer_account_id = "112233445566"
      peer_region     = "eu-west-3"
      peer_tgw_id     = "tgw-west3prod001"
      tags = {
        Name = "peer-to-west3-prod"
      }
    }
  }
}