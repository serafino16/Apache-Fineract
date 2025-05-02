include {
  path = find_in_parent_folders()
}

terraform {
  source = "../../../modules/vpc"
}

inputs = {
  vpc_name        = "prod-vpc-eu-west-3"
  cidr_block      = "10.2.0.0/16"
  azs             = ["eu-west-3a", "eu-west-3b", "eu-west-3c"]
  public_subnets  = ["10.2.0.0/24", "10.2.1.0/24"]
  private_subnets = ["10.2.2.0/24", "10.2.3.0/24"]
  tags = {
    Environment = "prod"
    Region      = "eu-west-3"
  }
}
