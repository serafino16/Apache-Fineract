include {
  path = find_in_parent_folders()
}

terraform {
  source = "../../../modules/route53"
}

inputs = {
  create_zone                = true
  zone_name                  = "stage.example.com"
  zone_comment               = "Stage zone for eu-central-1"
  force_destroy              = false
  vpc_associations           = {
    euc1 = {
      vpc_id     = "vpc-euc1-jkl012"
      vpc_region = "eu-central-1"
    }
  }
  tags                       = {
    Environment = "stage"
    Region      = "eu-central-1"
  }
  create_health_checks       = false
  health_checks              = {}
  create_failover_records    = false
  failover_records           = {}
  create_geolocation_records = false
  geolocation_records        = {}
}