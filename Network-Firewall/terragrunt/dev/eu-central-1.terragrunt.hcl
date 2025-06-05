inputs = {
  name        = "network-firewall-dev-eu-central-1"
  aws_region  = "eu-central-1"
  vpc_id      = "vpc-dev-12345678abcd"
  subnet_ids  = ["subnet-dev-1122abcd", "subnet-dev-3344efgh"]

  delete_protection             = false
  firewall_description          = "Dev Network Firewall eu-central-1"
  firewall_policy_description   = "Dev Firewall Policy"

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
        bucket_name = "dev-firewall-logs-12345678"
        prefix      = "eu-central-1/alerts/"
      }
    },
    {
      log_type = "FLOW"
      destination = {
        cloudwatch_log_group = "/aws/networkfirewall/flow-logs-dev-eu-central-1-9999"
      }
    }
  ]

  encryption_configuration = {
    type   = "CUSTOMER_KMS"
    key_id = "arn:aws:kms:eu-central-1:987654321098:key/dev-enc-key-1111-2222-3333-4444"
  }
}
