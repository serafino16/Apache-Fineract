include {
  path = find_in_parent_folders()
}

terraform {
  source = "../../../modules/route53"
}

inputs = {
  create_zone                = true
  zone_name                  = "stage.example.com"
  zone_comment               = "Stage zone for eu-west-3"
  force_destroy              = false
  vpc_associations           = {
    euw3 = {
      vpc_id     = "vpc-euw3-ghi789"
      vpc_region = "eu-west-3"
    }
  }
  tags                       = {
    Environment = "stage"
    Region      = "eu-west-3"
  }
  create_health_checks       = false
  health_checks              = {}
  create_failover_records    = false
  failover_records           = {}
  create_geolocation_records = false
  geolocation_records        = {}
}