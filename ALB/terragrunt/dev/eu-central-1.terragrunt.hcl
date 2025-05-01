include {
  path = find_in_parent_folders()
}

terraform {
  source = "git::git@github.com:your-org/alb-module.git//?ref=v1.0.0"
}

inputs = {
  alb_name                         = "dev-alb-eu-central-1"
  alb_internal                     = false
  alb_security_groups              = ["sg-02a3b4c5d6e7f8g9h", "sg-03b4c5d6e7f8g9h0i"]
  alb_subnets                      = ["subnet-09c0d1e2f3a4b5c6d", "subnet-0ac0d1e2f3a4b5c7e"]
  alb_enable_deletion_protection  = false
  target_group_name                = "dev-tg-eu-central-1"
  target_group_port                = 80
  target_group_protocol            = "HTTP"
  vpc_id                           = "vpc-01b2c3d4e5f67890b"
  health_check_protocol            = "HTTP"
  health_check_port                = "80"
  health_check_interval            = 30
  health_check_timeout             = 5
  health_check_unhealthy_threshold = 2
  health_check_healthy_threshold   = 2
  listener_port                    = 80
  listener_protocol                = "HTTP"
  common_tags = {
    Environment = "dev"
    Region      = "eu-central-1"
    Owner       = "DevOps Team"
  }
}
