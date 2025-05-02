terraform {
  source = "git::git@github.com:your-org/terraform-modules.git//nlb?ref=v1.0.0"
}

inputs = {
  nlb_name                          = "dev-nlb-eu-central-1"
  nlb_internal                      = true
  nlb_security_groups               = ["sg-0fbdc1a2a3b4c5d6e"]
  nlb_subnets                       = ["subnet-0aa1bb2cc3dd4ee5f", "subnet-0ff1bb2cc3aa4ee5a"]
  nlb_enable_deletion_protection   = false

  target_group_name                 = "dev-nlb-target-group"
  target_group_port                 = 8080
  target_group_protocol             = "TCP"

  vpc_id                            = "vpc-0abc1234def567890"

  health_check_protocol             = "TCP"
  health_check_port                 = "8080"
  health_check_interval             = 30
  health_check_timeout              = 5
  health_check_unhealthy_threshold = 2
  health_check_healthy_threshold   = 2

  listener_port                     = 80
  listener_protocol                 = "TCP"

  common_tags = {
    Project     = "apache-fineract"
    Environment = "dev"
    ManagedBy   = "terragrunt"
    Region      = "eu-central-1"
  }
}
