include {
  path = find_in_parent_folders()
}

terraform {
  source = "../../../modules/route53"
}

inputs = {
  create_zone                = true
  zone_name                  = "stage.example.com"
  zone_comment               = "Stage zone for eu-west-2"
  force_destroy              = false
  vpc_associations           = {
    euw2 = {
      vpc_id     = "vpc-euw2-def456"
      vpc_region = "eu-west-2"
    }
  }
  tags                       = {
    Environment = "stage"
    Region      = "eu-west-2"
  }
  create_health_checks       = false
  health_checks              = {}
  create_failover_records    = false
  failover_records           = {}
  create_geolocation_records = false
  geolocation_records        = {}
}