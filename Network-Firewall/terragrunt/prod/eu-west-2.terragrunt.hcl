inputs = {
  name        = "network-firewall-prod-eu-west-2"
  aws_region  = "eu-west-2"
  vpc_id      = "vpc-9z8y7x6w5v4u3t2s1"
  subnet_ids  = ["subnet-8765lmno", "subnet-4321pqrs"]

  delete_protection             = true
  firewall_description          = "Prod Network Firewall eu-west-2"
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
        bucket_name = "prod-firewall-logs-24681012"
        prefix      = "eu-west-2/alerts/"
      }
    },
    {
      log_type = "FLOW"
      destination = {
        cloudwatch_log_group = "/aws/networkfirewall/flow-logs-eu-west-2-8910"
      }
    }
  ]

  encryption_configuration = {
    type   = "CUSTOMER_KMS"
    key_id = "arn:aws:kms:eu-west-2:234567890123:key/efgh5678-ijkl-9012-mnop-qrst7890uvwx"
  }
}
