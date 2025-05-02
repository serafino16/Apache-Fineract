include {
  path = find_in_parent_folders()
}

terraform {
  source = "../../../modules/waf"
}

inputs = {
  waf_environments = {
    stage = {
      region  = "eu-west-2"
      alb_arn = "arn:aws:elasticloadbalancing:eu-west-2:123456789012:loadbalancer/app/my-alb/50dc6c495c0c9188"
      enable  = true
    }
  }

  common_tags = {
    Environment = "stage"
    Region      = "eu-west-2"
  }
}
