inputs = {
  name        = "network-firewall-prod-eu-west-3"
  aws_region  = "eu-west-3"
  vpc_id      = "vpc-abcd1234efgh5678"
  subnet_ids  = ["subnet-1357ijkl", "subnet-2468mnop"]

  delete_protection             = true
  firewall_description          = "Prod Network Firewall eu-west-3"
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
        bucket_name = "prod-firewall-logs-31415926"
        prefix      = "eu-west-3/alerts/"
      }
    },
    {
      log_type = "FLOW"
      destination = {
        cloudwatch_log_group = "/aws/networkfirewall/flow-logs-eu-west-3-1122"
      }
    }
  ]

  encryption_configuration = {
    type   = "CUSTOMER_KMS"
    key_id = "arn:aws:kms:eu-west-3:345678901234:key/ijkl9012-mnop-3456-qrst-uvwx7890yzab"
  }
}
