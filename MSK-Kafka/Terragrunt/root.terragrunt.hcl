locals {
  path_parts = split("/", path_relative_to_include())
  env        = local.path_parts[0]
  region     = local.path_parts[1]

  
  actual_region = local.env == "prod" ? (
    local.region == "eu-west-1"      ? "eu-west-2" :
    local.region == "eu-west-2"      ? "eu-west-1" :
    local.region == "eu-west-3"      ? "eu-west-1" :
    local.region == "eu-central-1"   ? "eu-west-1" :
    local.region
  ) : local.region
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