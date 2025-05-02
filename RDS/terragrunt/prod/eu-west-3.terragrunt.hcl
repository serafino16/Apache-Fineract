terraform {
  source = "git::https://github.com/your-repo.git//modules/rds?ref=v1.0"
}

provider "aws" {
  alias  = "prod-west-3"
  region = "eu-west-3"
}

inputs = {
  project_name          = "prod-project"
  environment           = "prod"
  cluster_name          = "prod-cluster-west-3"

  public_subnet_ids     = ["subnet-09c2cd45", "subnet-15d6ce78"]
  private_subnet_ids    = ["subnet-23f8hf91", "subnet-37g9ih02"]
  node_instance_types   = ["m5.large", "m5.xlarge"]
  node_desired_size     = 6
  node_max_size         = 10
  node_min_size         = 4
  node_disk_size        = 100
  ssh_key_name          = "prod-key-west-3"

  db_cluster_identifier = "prod-global-db-west-3"
  db_instance_class     = "db.m5.large"
  db_engine             = "aurora-postgresql"
  db_engine_version     = "13.6"
  master_username       = "adminprod3"
  master_password       = "securePasswordWest3"
  database_name         = "prodglobaldb3"

  backup_vault_name     = "prod-backup-vault-west-3"
  backup_iam_role_arn   = "arn:aws:iam::987654321113:role/aws-backup-prod-west-3"
  iam_role_name         = "rds-backup-role-prod-west-3"
}

