include {
  path = find_in_parent_folders()
}

terraform {
  source = "../../../../modules/lambda"
}

inputs = {
  regions = ["eu-west-3"]

  lambda_roles = {
    "eu-west-3" = "arn:aws:iam::111122223333:role/fineract-prod-lambda-role-eu-west-3"
  }

  sqs_queues = {
    "eu-west-3" = "https://sqs.eu-west-3.amazonaws.com/111122223333/fineract-prod-queue-eu-west-3"
  }

  tags = merge(local.common_tags, {
    Environment = "prod"
    Region      = "eu-west-3"
  })
}
