inputs = {
  name        = "network-firewall-prod-eu-west-1"
  aws_region  = "eu-west-1"
  vpc_id      = "vpc-0a1b2c3d4e5f6g7h8"
  subnet_ids  = ["subnet-1234abcd", "subnet-5678efgh"]

  delete_protection             = true
  firewall_description          = "Prod Network Firewall eu-west-1"
  firewall_policy_description   = "Prod Firewall Policy"

  stateless_default_actions          = ["aws:forward_to_sfe"]
  stateless_fragment_default_actions = ["aws:forward_to_sfe"]
  stateless_rule_groups              = []
  stateful_rule_groups               = []

  enable_stateful_engine_options = true
  stateful_rule_order            = "DEFAULT_ACTION_ORDER"

  enable_logging = true
  log_destination_configs = [
    {
      log_type = "ALERT"
      destination = {
        bucket_name = "prod-firewall-logs-987654321"
        prefix      = "eu-west-1/alerts/"
      }
    },
    {
      log_type = "FLOW"
      destination = {
        cloudwatch_log_group = "/aws/networkfirewall/flow-logs-eu-west-1-4567"
      }
    }
  ]

  encryption_configuration = {
    type   = "CUSTOMER_KMS"
    key_id = "arn:aws:kms:eu-west-1:123456789012:key/abcd1234-ef56-7890-gh12-ijkl3456mnop"
  }
}
