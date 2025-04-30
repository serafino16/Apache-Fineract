output "nlb_arn" {
  description = "ARN of the NLB"
  value       = aws_lb.this.arn
}

output "nlb_dns_name" {
  description = "DNS Name of the NLB"
  value       = aws_lb.this.dns_name
}

output "target_group_arn" {
  description = "ARN of the Target Group"
  value       = aws_lb_target_group.this.arn
}

output "listener_arn" {
  description = "ARN of the Listener"
  value       = aws_lb_listener.this.arn
}
