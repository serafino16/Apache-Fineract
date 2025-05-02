terraform {
  source = "git::git@github.com:your-org/terraform-modules.git//nlb?ref=v1.0.0"
}

inputs = {
  nlb_name                        = "prod-nlb-eu-west-1"
  nlb_internal                    = false
  nlb_security_groups             = ["sg-07bd1234abcd56789"]
  nlb_subnets                     = ["subnet-00aa11bb22cc33dd1", "subnet-11aa22bb33cc44dd2"]
  nlb_enable_deletion_protection = true

  target_group_name               = "prod-nlb-target-group"
  target_group_port               = 8080
  target_group_protocol           = "TCP"

  vpc_id                          = "vpc-01abc234def567890"

  health_check_protocol           = "TCP"
  health_check_port               = "8080"
  health_check_interval           = 30
  health_check_timeout            = 5
  health_check_unhealthy_threshold = 2
  health_check_healthy_threshold   = 2

  listener_port                   = 80
  listener_protocol               = "TCP"

  common_tags = {
    Project     = "apache-fineract"
    Environment = "prod"
    ManagedBy   = "terragrunt"
    Region      = "eu-west-1"
  }
}
provider "aws" {
  alias  = "primary-region"
  region = "eu-west-1"  
}

provider "aws" {
  alias  = "failover-region"
  region = "eu-west-2"  
}