output "lambda_function_arns" {
  description = "Map of region to Lambda function ARNs."
  value = {
    for region, lambda in aws_lambda_function.this : region => lambda.arn
  }
}

output "lambda_function_names" {
  description = "Map of region to Lambda function names."
  value = {
    for region, lambda in aws_lambda_function.this : region => lambda.function_name
  }
}

output "lambda_iam_role_arns" {
  description = "Map of region to IAM Role ARNs for Lambda functions."
  value = {
    for region, role in aws_iam_role.this : region => role.arn
  }
}