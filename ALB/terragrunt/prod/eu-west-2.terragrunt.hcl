include {
  path = find_in_parent_folders()
}

terraform {
  source = "git::git@github.com:your-org/alb-module.git//?ref=v1.0.0"
}

inputs = {
  alb_name                           = "prod-alb-eu-west-1"
  alb_internal                       = false
  alb_security_groups                = ["sg-12345678"]
  alb_subnets                        = ["subnet-aaaa", "subnet-bbbb"]
  alb_enable_deletion_protection    = true
  target_group_name                  = "prod-target-group"
  target_group_port                  = 80
  target_group_protocol              = "HTTP"
  vpc_id                             = "vpc-abcdef12"
  health_check_protocol              = "HTTP"
  health_check_port                  = "80"
  health_check_interval              = 30
  health_check_timeout               = 5
  health_check_unhealthy_threshold   = 2
  health_check_healthy_threshold     = 2
  listener_port                      = 80
  listener_protocol                  = "HTTP"
  common_tags = {
    Environment = "prod"
    Region      = "eu-west-2"
    Owner       = "DevOps Team"
  }
}
