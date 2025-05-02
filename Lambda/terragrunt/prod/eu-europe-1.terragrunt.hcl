include {
  path = find_in_parent_folders()
}

terraform {
  source = "../../../../modules/lambda"
}

inputs = {
  regions = ["eu-west-1"]

  lambda_roles = {
    "eu-west-1" = "arn:aws:iam::111122223333:role/fineract-prod-lambda-role-eu-west-1"
  }

  sqs_queues = {
    "eu-west-1" = "https://sqs.eu-west-1.amazonaws.com/111122223333/fineract-prod-queue-eu-west-1"
  }

  tags = merge(local.common_tags, {
    Environment = "prod"
    Region      = "eu-west-1"
  })
}
