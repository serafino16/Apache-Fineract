include {
  path = find_in_parent_folders()
}

terraform {
  source = "../../../modules/waf"
}

inputs = {
  waf_environments = {
    dev = {
      region  = "eu-central-1"
      alb_arn = "arn:aws:elasticloadbalancing:eu-central-1:123456789012:loadbalancer/app/dev-alb/50dc6c495c0c9188"
      enable  = false
    }
  }

  common_tags = {
    Environment = "prod"
    Region      = "eu-central-1"
  }
}
