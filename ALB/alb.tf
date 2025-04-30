resource "aws_lb" "this" {
  provider           = aws.prod
  name               = var.alb_name
  internal           = var.alb_internal
  load_balancer_type = "application"
  security_groups    = var.alb_security_groups
  subnets            = var.alb_subnets

  enable_deletion_protection = var.alb_enable_deletion_protection

  tags = var.common_tags
}

resource "aws_lb_target_group" "this" {
  provider = aws.devstage
  name     = var.target_group_name
  port     = var.target_group_port
  protocol = var.target_group_protocol
  vpc_id   = var.vpc_id

  health_check {
    protocol            = var.health_check_protocol
    port                = var.health_check_port
    interval            = var.health_check_interval
    timeout             = var.health_check_timeout
    unhealthy_threshold = var.health_check_unhealthy_threshold
    healthy_threshold   = var.health_check_healthy_threshold
  }

  tags = var.common_tags
}

resource "aws_lb_listener" "this" {
  provider          = aws.prod
  load_balancer_arn = aws_lb.this.arn
  port              = var.listener_port
  protocol          = var.listener_protocol

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.this.arn
  }
}
