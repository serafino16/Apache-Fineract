terraform {
  source = "../../modules/eks-cluster"
}

inputs = {
  project_name          = "apache-fineract"
  environment           = "stage"
  cluster_name          = "apache-fineract-cluster-stage"
  public_subnet_ids     = ["subnet-29f33b55", "subnet-53e5d6bc"]
  private_subnet_ids    = ["subnet-4c6a8f61", "subnet-2d01e350"]
  node_instance_types   = ["t3.medium"]
  node_desired_size     = 3
  node_max_size         = 5
  node_min_size         = 2
  node_disk_size        = 20
  ssh_key_name          = "stage-ssh-key"
}

provider "aws" {
  region = "eu-west-2"
}
