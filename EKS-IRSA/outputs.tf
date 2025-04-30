output "iam_role_arn" {
  description = "ARN of the created IAM Role."
  value       = aws_iam_role.this.arn
}

output "iam_role_name" {
  description = "Name of the created IAM Role."
  value       = aws_iam_role.this.name
}

output "oidc_provider_arn" {
  description = "ARN of the created OIDC Provider."
  value       = aws_iam_openid_connect_provider.this.arn
}
