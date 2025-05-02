include {
  path = find_in_parent_folders()
}

terraform {
  source = "../../../../modules/lambda"
}

inputs = {
  regions = ["eu-central-1"]

  lambda_roles = {
    "eu-central-1" = "arn:aws:iam::111122223333:role/fineract-dev-lambda-role-eu-central-1"
  }

  sqs_queues = {
    "eu-central-1" = "https://sqs.eu-central-1.amazonaws.com/111122223333/fineract-dev-queue-eu-central-1"
  }

  lambda_handler     = "index.lambda_handler"
  lambda_runtime     = "python3.8"
  lambda_zip_path    = "lambda/dist/fineract-dev-function.zip"

  tags = {
    Project     = "apache-fineract"
    Environment = "dev"
    Region      = "eu-central-1"
    ManagedBy   = "terraform"
  }
}
