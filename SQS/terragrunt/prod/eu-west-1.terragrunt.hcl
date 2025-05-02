include {
  path = find_in_parent_folders()
}

terraform {
  source = "../../../modules/sqs"
}

inputs = {
  regions                    = ["eu-west-1"]
  delay_seconds              = 0
  message_retention_seconds  = 86400
  tags                       = {
    Environment = "prod"
    Region      = "eu-west-1"
  }
}

