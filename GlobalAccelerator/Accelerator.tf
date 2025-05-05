resource "aws_globalaccelerator_accelerator" "main" {
  name               = var.accelerator_name
  enabled            = true
  ip_address_type    = "IPV4"
  enable_deletion_protection = var.deletion_protection

  tags = var.tags
}

resource "aws_globalaccelerator_endpoint_group" "main" {
  for_each = var.endpoint_groups

  accelerator_arn = aws_globalaccelerator_accelerator.main.id
  region          = each.key
  endpoint_group_region = each.key

  endpoint_configuration {
    endpoint_id = each.value.endpoint_id
    weight      = each.value.weight
  }

  traffic_dial_percentage = 100
}