output "queue_urls" {
  description = "Map of region to SQS Queue URLs."
  value = {
    for region, queue in aws_sqs_queue.this : region => queue.id
  }
}

output "queue_arns" {
  description = "Map of region to SQS Queue ARNs."
  value = {
    for region, queue in aws_sqs_queue.this : region => queue.arn
  }
}
