variable "lambda_name" {
  description = "Name of the Lambda consumer function"
  type        = string
}

variable "handler" {
  description = "Handler method"
  type        = string
}

variable "runtime" {
  description = "Lambda runtime"
  type        = string
}

variable "memory_size" {
  description = "Memory size in MB"
  type        = number
}

variable "timeout" {
  description = "Timeout in seconds"
  type        = number
}

variable "lambda_zip_file" {
  description = "Path to Lambda deployment package"
  type        = string
}

variable "environment_variables" {
  description = "Map of environment variables"
  type        = map(string)
}

variable "lambda_role_arn" {
  description = "IAM role ARN for Lambda function"
  type        = string
}

variable "event_source_arn" {
  description = "ARN of the MSK topic or source"
  type        = string
}

variable "starting_position" {
  description = "Where to start reading (e.g. LATEST)"
  type        = string
  default     = "LATEST"
}

variable "batch_size" {
  description = "Max number of records per batch"
  type        = number
  default     = 100
}

variable "enabled" {
  description = "Enable the event source mapping"
  type        = bool
  default     = true
}

variable "topic_name" {
  description = "Kafka topic name"
  type        = string
}

variable "consumer_group_id" {
  description = "Kafka consumer group ID"
  type        = string
}

