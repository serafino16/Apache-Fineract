inputs = {
  name        = "network-firewall-prod-eu-central-1"
  aws_region  = "eu-central-1"
  vpc_id      = "vpc-1a2b3c4d5e6f7g8h9"
  subnet_ids  = ["subnet-abcdef12", "subnet-3456ghij"]

  delete_protection             = true
  firewall_description          = "Prod Network Firewall eu-central-1"
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
        bucket_name = "prod-firewall-logs-78901234"
        prefix      = "eu-central-1/alerts/"
      }
    },
    {
      log_type = "FLOW"
      destination = {
        cloudwatch_log_group = "/aws/networkfirewall/flow-logs-eu-central-1-5566"
      }
    }
  ]

  encryption_configuration = {
    type   = "CUSTOMER_KMS"
    key_id = "arn:aws:kms:eu-central-1:456789012345:key/mnop3456-qrst-7890-uvwx-yzab1234cdef"
  }
}
