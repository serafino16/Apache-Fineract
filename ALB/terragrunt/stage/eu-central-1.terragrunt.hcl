include {
  path = find_in_parent_folders()
}

terraform {
  source = "git::git@github.com:your-org/alb-module.git//?ref=v1.0.0"
}

inputs = {
  alb_name                         = "stage-alb-eu-central-1"
  alb_internal                     = false
  alb_security_groups              = ["sg-0f1a2b3c4d5e6f7a8", "sg-1a2b3c4d5e6f7a8b9"]
  alb_subnets                      = ["subnet-07a8b9c0d1e2f3a4b", "subnet-08b9c0d1e2f3a4b5c"]
  alb_enable_deletion_protection  = false
  target_group_name                = "stage-tg-eu-central-1"
  target_group_port                = 80
  target_group_protocol            = "HTTP"
  vpc_id                           = "vpc-0a1b2c3d4e5f6789a"
  health_check_protocol            = "HTTP"
  health_check_port                = "80"
  health_check_interval            = 30
  health_check_timeout             = 5
  health_check_unhealthy_threshold = 2
  health_check_healthy_threshold   = 2
  listener_port                    = 80
  listener_protocol                = "HTTP"
  common_tags = {
    Environment = "stage"
    Region      = "eu-central-1"
    Owner       = "DevOps Team"
  }
}
