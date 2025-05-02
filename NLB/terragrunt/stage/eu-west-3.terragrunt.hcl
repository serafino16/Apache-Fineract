include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "../../../../modules/nlb"
}

inputs = {
  nlb_name                            = "stage-eu-west-3-nlb"
  nlb_internal                        = false
  nlb_security_groups                = ["sg-021eu3"]
  nlb_subnets                        = ["subnet-111eu3", "subnet-112eu3"]
  nlb_enable_deletion_protection     = false
  target_group_name                  = "stage-eu-west-3-tg"
  target_group_port                  = 8080
  target_group_protocol              = "TCP"
  vpc_id                             = "vpc-euw3-stage"
  health_check_protocol              = "TCP"
  health_check_port                  = "8080"
  health_check_interval              = 30
  health_check_timeout               = 5
  health_check_unhealthy_threshold   = 2
  health_check_healthy_threshold     = 2
  listener_port                      = 80
  listener_protocol                  = "TCP"

  common_tags = {
    Project     = "apache-fineract"
    Environment = "stage"
    Region      = "eu-west-3"
  }
}