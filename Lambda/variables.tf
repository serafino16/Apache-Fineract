output "lambda_function_name" {
  description = "Name of the Lambda consumer function"
  value       = aws_lambda_function.this.function_name
}

output "lambda_function_arn" {
  description = "ARN of the Lambda consumer function"
  value       = aws_lambda_function.this.arn
}

output "event_source_mapping_uuid" {
  description = "UUID of the event source mapping"
  value       = aws_lambda_event_source_mapping.kafka_source.id
}

output "invoke_arn" {
  description = "Invoke ARN for API Gateway or event sources"
  value       = aws_lambda_function.this.invoke_arn
}

