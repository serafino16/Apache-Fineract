include {
  path = find_in_parent_folders()
}

terraform {
  source = "../../../../modules/lambda"
}

inputs = {
  regions = ["eu-central-1"]

  lambda_roles = {
    "eu-central-1" = "arn:aws:iam::111122223333:role/fineract-stage-lambda-role-eu-central-1"
  }

  sqs_queues = {
    "eu-central-1" = "https://sqs.eu-central-1.amazonaws.com/111122223333/fineract-stage-queue-eu-central-1"
  }

  tags = merge(local.common_tags, {
    Environment = "stage"
    Region      = "eu-central-1"
  })
}
