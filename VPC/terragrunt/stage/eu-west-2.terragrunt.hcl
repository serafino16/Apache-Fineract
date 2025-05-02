include {
  path = find_in_parent_folders()
}

terraform {
  source = "../../../modules/vpc"
}

inputs = {
  vpc_name        = "stage-vpc-eu-west-2"
  cidr_block      = "10.1.0.0/16"
  azs             = ["eu-west-2a", "eu-west-2b", "eu-west-2c"]
  public_subnets  = ["10.1.0.0/24", "10.1.1.0/24"]
  private_subnets = ["10.1.2.0/24", "10.1.3.0/24"]
  tags = {
    Environment = "stage"
    Region      = "eu-west-2"
  }
}
