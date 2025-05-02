terraform {
  source = "git::https://github.com/your-repo.git//modules/rds?ref=v1.0"
}

provider "aws" {
  alias  = "prod-west-1"
  region = "eu-west-1"
}

inputs = {
  project_name          = "prod-project"
  environment           = "prod"
  cluster_name          = "prod-cluster-west-1"

  public_subnet_ids     = ["subnet-07a1bc12", "subnet-13b4de89"]
  private_subnet_ids    = ["subnet-21c5f678", "subnet-35d6f910"]
  node_instance_types   = ["m5.large", "m5.xlarge"]
  node_desired_size     = 6
  node_max_size         = 10
  node_min_size         = 4
  node_disk_size        = 100
  ssh_key_name          = "prod-key-west-1"

  db_cluster_identifier = "prod-global-db-west-1"
  db_instance_class     = "db.m5.large"
  db_engine             = "aurora-postgresql"
  db_engine_version     = "13.6"
  master_username       = "adminprod1"
  master_password       = "securePasswordWest1"
  database_name         = "prodglobaldb1"

  backup_vault_name     = "prod-backup-vault-west-1"
  backup_iam_role_arn   = "arn:aws:iam::987654321111:role/aws-backup-prod-west-1"
  iam_role_name         = "rds-backup-role-prod-west-1"
}
