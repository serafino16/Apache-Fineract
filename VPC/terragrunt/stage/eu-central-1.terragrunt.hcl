include {
  path = find_in_parent_folders()
}

terraform {
  source = "../../../modules/vpc"
}

inputs = {
  vpc_name        = "stage-vpc-eu-central-1"
  cidr_block      = "10.3.0.0/16"
  azs             = ["eu-central-1a", "eu-central-1b", "eu-central-1c"]
  public_subnets  = ["10.3.0.0/24", "10.3.1.0/24"]
  private_subnets = ["10.3.2.0/24", "10.3.3.0/24"]
  tags = {
    Environment = "stage"
    Region      = "eu-central-1"
  }
}

