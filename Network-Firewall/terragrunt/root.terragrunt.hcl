
remote_state {
  backend = "s3"
  config = {
    bucket         = "my-terraform-state-bucket"
    key            = "${path_relative_to_include()}/terraform.tfstate"
    region         = "eu-west-1"
    encrypt        = true
    dynamodb_table = "terraform-locks"
  }
}

generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite"
  contents  = <<EOF
provider "aws" {
  region = var.aws_region
  assume_role {
    role_arn = "arn:aws:iam::123456789012:role/TerraformRole"
  }
}
EOF
}
