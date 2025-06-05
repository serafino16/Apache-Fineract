inputs = {
  name        = "network-firewall-stage-eu-west-2"
  aws_region  = "eu-west-2"
  vpc_id      = "vpc-stage-euw2-2345abcd"
  subnet_ids  = ["subnet-stage-euw2-6789abcd", "subnet-stage-euw2-1011efgh"]

  delete_protection             = true
  firewall_description          = "Stage Network Firewall eu-west-2"
  firewall_policy_description   = "Stage Firewall Policy"

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
        bucket_name = "stage-firewall-logs-euw2-3333abcd"
        prefix      = "eu-west-2/alerts/"
      }
    },
    {
      log_type = "FLOW"
      destination = {
        cloudwatch_log_group = "/aws/networkfirewall/flow-logs-stage-eu-west-2-4444"
      }
    }
  ]

  encryption_configuration = {
    type   = "CUSTOMER_KMS"
    key_id = "arn:aws:kms:eu-west-2:987654321098:key/stage-enc-key-euw2-dddd-eeee-ffff"
  }
}
