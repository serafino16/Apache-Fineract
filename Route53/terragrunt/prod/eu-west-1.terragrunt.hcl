include {
  path = find_in_parent_folders()
}

terraform {
  source = "../../../modules/route53"
}

inputs = {
  create_zone                = true
  zone_name                  = "prod.example.com"
  zone_comment               = "Production zone for eu-west-1"
  force_destroy              = false
  vpc_associations           = {
    euw1 = {
      vpc_id     = "vpc-euw1-abc123"
      vpc_region = "eu-west-1"
    }
  }
  tags                       = {
    Environment = "prod"
    Region      = "eu-west-1"
  }
  create_health_checks       = true
  health_checks = {
    "healthcheck-1" = {
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
      records         = ["203.0.113.1"]
      health_check_id = "healthcheck-1"
    }
    "failover-record-2" = {
      name            = "api.prod-backup.example.com"
      type            = "A"
      set_identifier  = "secondary"
      failover        = "SECONDARY"
      ttl             = 60
      records         = ["203.0.113.2"]
      health_check_id = "healthcheck-1"
    }
  }
  create_geolocation_records = true
  geolocation_records = {
    "geolocation-record-1" = {
      name           = "api.prod.example.com"
      type           = "A"
      set_identifier = "us-west"
      ttl            = 60
      records        = ["203.0.113.3"]
      continent      = "EU"
      country        = "EUROPE"
    }
  }
}
