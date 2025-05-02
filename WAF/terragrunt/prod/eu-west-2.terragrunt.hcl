include {
  path = find_in_parent_folders()
}

terraform {
  source = "../../../modules/waf"
}

inputs = {
  waf_environments = {
    prod = {
      region  = "eu-west-2"
      alb_arn = "arn:aws:elasticloadbalancing:eu-west-2:987654321098:loadbalancer/app/prod-alb/50dc6c495c0c9188"
      enable  = true
    }
  }

  common_tags = {
    Environment = "prod"
    Region      = "eu-west-2"
  }
}
