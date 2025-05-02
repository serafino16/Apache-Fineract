include {
  path = find_in_parent_folders()
}

terraform {
  source = "../../../../modules/lambda"
}

inputs = {
  regions = ["eu-west-2"]

  lambda_roles = {
    "eu-west-2" = "arn:aws:iam::111122223333:role/fineract-stage-lambda-role-eu-west-2"
  }

  sqs_queues = {
    "eu-west-2" = "https://sqs.eu-west-2.amazonaws.com/111122223333/fineract-stage-queue-eu-west-2"
  }

  tags = merge(local.common_tags, {
    Environment = "stage"
    Region      = "eu-west-2"
  })
}
