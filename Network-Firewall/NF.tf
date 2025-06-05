provider "aws" {
  region = var.aws_region
}

resource "aws_networkfirewall_firewall_policy" "this" {
  name        = "${var.name}-policy"
  description = var.firewall_policy_description

  firewall_policy {
    stateless_default_actions          = var.stateless_default_actions
    stateless_fragment_default_actions = var.stateless_fragment_default_actions

    dynamic "stateless_rule_group_reference" {
      for_each = var.stateless_rule_groups
      content {
        resource_arn = stateless_rule_group_reference.value
        priority     = 100
      }
    }

    dynamic "stateful_rule_group_reference" {
      for_each = var.stateful_rule_groups
      content {
        resource_arn = stateful_rule_group_reference.value
      }
    }

    dynamic "stateful_engine_options" {
      for_each = var.enable_stateful_engine_options ? [1] : []
      content {
        rule_order = var.stateful_rule_order
      }
    }
  }

  tags = var.tags
}

resource "aws_networkfirewall_firewall" "this" {
  name                = var.name
  description         = var.firewall_description
  firewall_policy_arn = aws_networkfirewall_firewall_policy.this.arn
  vpc_id              = var.vpc_id
  delete_protection   = var.delete_protection

  dynamic "subnet_mapping" {
    for_each = var.subnet_ids
    content {
      subnet_id = subnet_mapping.value
    }
  }

  tags = var.tags
}


resource "aws_networkfirewall_logging_configuration" "this" {
  count        = var.enable_logging ? 1 : 0
  firewall_arn = aws_networkfirewall_firewall.this.arn

  logging_configuration {
    dynamic "log_destination_config" {
      for_each = var.log_destination_configs
      content {
        log_type = log_destination_config.value.log_type
        log_destination {
          bucket_name         = lookup(log_destination_config.value.destination, "bucket_name", null)
          prefix              = lookup(log_destination_config.value.destination, "prefix", null)
          cloudwatch_log_group = lookup(log_destination_config.value.destination, "cloudwatch_log_group", null)
        }
      }
    }
  }
}
