

inputs = {
  lambda_handler  = local.lambda_handler
  lambda_runtime  = local.lambda_runtime
  lambda_zip_path = local.lambda_zip_path
  tags            = local.common_tags
}
locals {
  path_parts = split("/", path_relative_to_include())
  env        = local.path_parts[0]
  region     = local.path_parts[1]

  # Only override for prod
  actual_region = local.env == "prod" ? (
    local.region == "eu-west-1"      ? "eu-west-2" :
    local.region == "eu-west-2"      ? "eu-west-1" :
    local.region == "eu-west-3"      ? "eu-west-1" :
    local.region == "eu-central-1"   ? "eu-west-1" :
    local.region
  ) : local.region
    lambda_handler     = "index.lambda_handler"
    lambda_runtime     = "python3.8"
    lambda_zip_path    = "../../artifacts/lambda.zip"
    common_tags = {
    Project = "apache-fineract"
}

remote_state {
  backend = "s3"
  config = {
    bucket         = "my-terragrunt-state-bucket"
    key            = "${path_relative_to_include()}/terraform.tfstate"
    region         = "eu-west-1"
    encrypt        = true
    dynamodb_table = "my-terraform-locks"
  }
}

generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite"
  contents  = <<EOF
provider "aws" {
  region = "${local.actual_region}"
  alias  = "main"
}
EOF
}