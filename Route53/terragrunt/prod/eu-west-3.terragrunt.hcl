include {
  path = find_in_parent_folders()
}

terraform {
  source = "../../../modules/route53"
}

inputs = {
  create_zone                = true
  zone_name                  = "prod.example.com"
  zone_comment               = "Production zone for eu-west-3"
  force_destroy              = false
  vpc_associations           = {
    euw3 = {
      vpc_id     = "vpc-euw3-ghi789"
      vpc_region = "eu-west-3"
    }
  }
  tags                       = {
    Environment = "prod"
    Region      = "eu-west-3"
  }
  create_health_checks       = true
  health_checks = {
    "healthcheck-3" = {
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
      records         = ["203.0.113.4"]
      health_check_id = "healthcheck-3"
    }
    "failover-record-2" = {
      name            = "api.prod-backup.example.com"
      type            = "A"
      set_identifier  = "secondary"
      failover        = "SECONDARY"
      ttl             = 60
      records         = ["203.0.113.5"]
      health_check_id = "healthcheck-3"
    }
  }
  create_geolocation_records = true
  geolocation_records = {
    "geolocation-record-3" = {
      name           = "api.prod.example.com"
      type           = "A"
      set_identifier = "eu-west"
      ttl            = 60
      records        = ["203.0.113.6"]
      continent      = "EU"
      country        = "FR"
    }
  }
}
