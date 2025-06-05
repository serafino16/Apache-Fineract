inputs = {
  name        = "network-firewall-stage-eu-central-1"
  aws_region  = "eu-central-1"
  vpc_id      = "vpc-stage-87654321abcd"
  subnet_ids  = ["subnet-stage-5566abcd", "subnet-stage-7788efgh"]

  delete_protection             = true
  firewall_description          = "Stage Network Firewall eu-central-1"
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
        bucket_name = "stage-firewall-logs-87654321"
        prefix      = "eu-central-1/alerts/"
      }
    },
    {
      log_type = "FLOW"
      destination = {
        cloudwatch_log_group = "/aws/networkfirewall/flow-logs-stage-eu-central-1-8888"
      }
    }
  ]

  encryption_configuration = {
    type   = "CUSTOMER_KMS"
    key_id = "arn:aws:kms:eu-central-1:987654321098:key/stage-enc-key-aaaa-bbbb-cccc-dddd"
  }
}
