variable "name" {
  description = "Name of the Network Firewall"
  type        = string
}

variable "aws_region" {
  description = "AWS region"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID to attach the firewall"
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs for the firewall endpoint(s)"
  type        = list(string)
}

variable "delete_protection" {
  description = "Whether to enable deletion protection"
  type        = bool
  default     = false
}

variable "firewall_description" {
  description = "Description for the Network Firewall"
  type        = string
  default     = ""
}

variable "firewall_policy_description" {
  description = "Description for the Firewall Policy"
  type        = string
  default     = ""
}

variable "stateless_default_actions" {
  description = "Default stateless actions (e.g., aws:forward_to_sfe)"
  type        = list(string)
  default     = ["aws:forward_to_sfe"]
}

variable "stateless_fragment_default_actions" {
  description = "Default stateless fragment actions"
  type        = list(string)
  default     = ["aws:forward_to_sfe"]
}

variable "stateless_rule_groups" {
  description = "List of stateless rule group ARNs"
  type        = list(string)
  default     = []
}

variable "stateful_rule_groups" {
  description = "List of stateful rule group ARNs"
  type        = list(string)
  default     = []
}

variable "enable_stateful_engine_options" {
  description = "Whether to enable stateful engine options"
  type        = bool
  default     = false
}

variable "stateful_rule_order" {
  description = "Rule order for stateful rules (e.g., DEFAULT_ACTION_ORDER)"
  type        = string
  default     = "DEFAULT_ACTION_ORDER"
}

variable "enable_logging" {
  description = "Enable logging configuration"
  type        = bool
  default     = false
}

variable "log_destination_configs" {
  description = <<EOF
List of log destination configurations, e.g.:
[
  {
    log_type = "ALERT"
    destination = {
      bucket_name = "my-bucket"
      prefix = "firewall-logs/"
    }
  },
  {
    log_type = "FLOW"
    destination = {
      cloudwatch_log_group = "/aws/networkfirewall/logs"
    }
  }
]
EOF
  type = list(object({
    log_type   = string
    destination = map(string)
  }))
  default = []
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}
