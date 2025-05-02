include {
  path = find_in_parent_folders()
}

terraform {
  source = "../../../modules/sqs"
}

inputs = {
  regions                    = ["eu-central-1"]
  delay_seconds              = 0
  message_retention_seconds  = 86400
  tags                       = {
    Environment = "dev"
    Region      = "eu-central-1"
  }
}
