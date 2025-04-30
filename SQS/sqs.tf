resource "aws_sqs_queue" "this" {
  for_each = toset(var.regions)

  name                        = "user-creation-queue-${each.value}"
  delay_seconds               = var.delay_seconds
  message_retention_seconds   = var.message_retention_seconds

  tags = var.tags
}
