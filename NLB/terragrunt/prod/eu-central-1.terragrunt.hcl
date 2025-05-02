terraform {
  source = "git::git@github.com:your-org/terraform-modules.git//nlb?ref=v1.0.0"
}

inputs = {
  nlb_name                        = "prod-nlb-eu-central-1"
  nlb_internal                    = false
  nlb_security_groups             = ["sg-04de4567abcd89012"]
  nlb_subnets                     = ["subnet-345cde678f9012345", "subnet-543edc876f1094321"]
  nlb_enable_deletion_protection = true

  target_group_name               = "prod-nlb-target-group"
  target_group_port               = 8080
  target_group_protocol           = "TCP"

  vpc_id                          = "vpc-04jkl567cde890123"

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
    Region      = "eu-central-1"
  }
}
provider "aws" {
  alias  = "primary-region"
  region = "eu-central-1"  
}

provider "aws" {
  alias  = "failover-region"
  region = "eu-west-1"  
}