variable "regions" {
  description = "List of regions to deploy the Lambda functions in."
  type        = list(string)
}

variable "lambda_roles" {
  description = "Map of region => IAM Role ARN for the Lambda function."
  type        = map(string)
}

variable "sqs_queues" {
  description = "Map of region => SQS Queue URL for the Lambda environment variable."
  type        = map(string)
}

variable "lambda_handler" {
  description = "Lambda function handler (e.g., index.lambda_handler)."
  type        = string
  default     = "index.lambda_handler"
}

variable "lambda_runtime" {
  description = "Runtime for the Lambda function."
  type        = string
  default     = "python3.8"
}

variable "lambda_zip_path" {
  description = "Path to the Lambda deployment package zip file."
  type        = string
}

variable "tags" {
  description = "Tags to assign to the Lambda function."
  type        = map(string)
  default     = {}
}
