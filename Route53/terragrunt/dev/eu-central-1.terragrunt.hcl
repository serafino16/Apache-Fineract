include {
  path = find_in_parent_folders()
}

terraform {
  source = "../../../modules/route53"
}

inputs = {
  create_zone                = true
  zone_name                  = "dev.example.com"
  zone_comment               = "Development zone for eu-west-1"
  force_destroy              = false
  vpc_associations           = {
    euw1 = {
      vpc_id     = "vpc-euw1-abc123"
      vpc_region = "eu-west-1"
    }
  }
  tags                       = {
    Environment = "dev"
    Region      = "eu-west-1"
  }
  create_health_checks       = true
  health_checks = {
    "healthcheck-1" = {
      fqdn              = "api.dev.example.com"
      port              = 80
      type              = "HTTP"
      resource_path     = "/health"
      failure_threshold = 3
      request_interval  = 30
    }
  }
  create_failover_records    = false
  failover_records           = {}
  create_geolocation_records = true
  geolocation_records = {
    "geolocation-record-1" = {
      name           = "api.dev.example.com"
      type           = "A"
      set_identifier = "us-west"
      ttl            = 60
      records        = ["203.0.113.7"]
      continent      = "NA"
      country        = "US"
    }
  }
}
