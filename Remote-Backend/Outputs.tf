output "s3_bucket_name" {
  description = "Terraform state S3 bucket"
  value       = aws_s3_bucket.terraform_state.id
}

output "dynamodb_table_name" {
  description = "Terraform lock DynamoDB table"
  value       = aws_dynamodb_table.terraform_lock.id
}
