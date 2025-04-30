output "id" {
  description = "The ID of the EBS volume."
  value       = aws_ebs_volume.this.id
}

output "arn" {
  description = "The ARN of the EBS volume."
  value       = aws_ebs_volume.this.arn
}
