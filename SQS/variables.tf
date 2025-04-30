variable "regions" {
  description = "List of AWS regions where SQS queues will be created."
  type        = list(string)
}

variable "delay_seconds" {
  description = "The time in seconds that the delivery of all messages in the queue will be delayed."
  type        = number
  default     = 0
}

variable "message_retention_seconds" {
  description = "The number of seconds Amazon SQS retains a message."
  type        = number
  default     = 86400
}

variable "tags" {
  description = "A map of tags to assign to the SQS queues."
  type        = map(string)
  default     = {}
}
