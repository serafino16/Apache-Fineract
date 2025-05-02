terraform {
  source = "git::git@github.com:your-org/terraform-modules.git//nlb?ref=v1.0.0"
}

inputs = {
  nlb_name                        = "prod-nlb-eu-west-3"
  nlb_internal                    = false
  nlb_security_groups             = ["sg-03cd3456abcd78901"]
  nlb_subnets                     = ["subnet-234bcd567ef890123", "subnet-432dcb765fe098321"]
  nlb_enable_deletion_protection = true

  target_group_name               = "prod-nlb-target-group"
  target_group_port               = 8080
  target_group_protocol           = "TCP"

  vpc_id                          = "vpc-03ghi456bcd789012"

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
    Region      = "eu-west-3"
  }
}
provider "aws" {
  alias  = "primary-region"
  region = "eu-west-3"  
}

provider "aws" {
  alias  = "failover-region"
  region = "eu-west-1"  
}