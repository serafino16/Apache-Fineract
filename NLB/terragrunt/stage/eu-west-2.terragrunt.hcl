inputs = {
  nlb_name                         = "stage-eu-west-2-nlb"
  nlb_internal                     = false
  nlb_security_groups              = ["sg-0a1b2c3d4e5f6g7h8"]
  nlb_subnets                      = ["subnet-0abcd1234ef567892", "subnet-0abcd1234ef567893"]
  nlb_enable_deletion_protection  = false
  target_group_name               = "stage-eu-west-2-target-group"
  target_group_port               = 8080
  target_group_protocol           = "TCP"
  vpc_id                          = "vpc-0123456789abcdef1"
  health_check_protocol           = "TCP"
  health_check_port               = "8080"
  health_check_interval           = 30
  health_check_timeout            = 5
  health_check_unhealthy_threshold = 2
  health_check_healthy_threshold  = 2
  listener_port                   = 80
  listener_protocol               = "TCP"
  common_tags = {
    Project     = "apache-fineract"
    Environment = "stage"
    Region      = "eu-west-2"
    Owner       = "devops-team"
  }
}