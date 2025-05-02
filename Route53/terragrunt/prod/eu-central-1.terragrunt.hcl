include {
  path = find_in_parent_folders()
}

terraform {
  source = "../../../modules/route53"
}

inputs = {
  create_zone                = true
  zone_name                  = "prod.example.com"
  zone_comment               = "Production zone for eu-central-1"
  force_destroy              = false
  vpc_associations           = {
    euc1 = {
      vpc_id     = "vpc-euc1-jkl012"
      vpc_region = "eu-central-1"
    }
  }
  tags                       = {
    Environment = "prod"
    Region      = "eu-central-1"
  }
  create_health_checks       = true
  health_checks = {
    "healthcheck-4" = {
      fqdn              = "api.prod.example.com"
      port              = 80
      type              = "HTTP"
      resource_path     = "/health"
      failure_threshold = 3
      request_interval  = 30
    }
  }
  create_failover_records    = true
  failover_records = {
    "failover-record-1" = {
      name            = "api.prod.example.com"
      type            = "A"
      set_identifier  = "primary"
      failover        = "PRIMARY"
      ttl             = 60
      records         = ["198.51.100.4"]
      health_check_id = "healthcheck-4"
    }
    "failover-record-2" = {
      name            = "api.prod-backup.example.com"
      type            = "A"
      set_identifier  = "secondary"
      failover        = "SECONDARY"
      ttl             = 60
      records         = ["198.51.100.5"]
      health_check_id = "healthcheck-4"
    }
  }
  create_geolocation_records = true
  geolocation_records = {
    "geolocation-record-4" = {
      name           = "api.prod.example.com"
      type           = "A"
      set_identifier = "central-europe"
      ttl            = 60
      records        = ["198.51.100.6"]
      continent      = "EU"
      country        = "DE"
    }
  }
}
