include {
  path = find_in_parent_folders()
}

terraform {
  source = "../../../modules/vpc"
}

inputs = {
  vpc_name        = "dev-vpc-eu-central-1"
  cidr_block      = "10.4.0.0/16"
  azs             = ["eu-central-1a", "eu-central-1b", "eu-central-1c"]
  public_subnets  = ["10.4.0.0/24", "10.4.1.0/24"]
  private_subnets = ["10.4.2.0/24", "10.4.3.0/24"]
  tags = {
    Environment = "dev"
    Region      = "eu-central-1"
  }
}
