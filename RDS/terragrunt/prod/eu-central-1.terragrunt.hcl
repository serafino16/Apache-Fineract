terraform {
  source = "git::https://github.com/your-repo.git//modules/rds?ref=v1.0"
}

provider "aws" {
  alias  = "prod-central-1"
  region = "eu-central-1"
}

inputs = {
  project_name          = "prod-project"
  environment           = "prod"
  cluster_name          = "prod-cluster-central-1"

  public_subnet_ids     = ["subnet-10d3dc56", "subnet-16e7df89"]
  private_subnet_ids    = ["subnet-24g0ij03", "subnet-38h1jk14"]
  node_instance_types   = ["m5.large", "m5.xlarge"]
  node_desired_size     = 6
  node_max_size         = 10
  node_min_size         = 4
  node_disk_size        = 100
  ssh_key_name          = "prod-key-central-1"

  db_cluster_identifier = "prod-global-db-central-1"
  db_instance_class     = "db.m5.large"
  db_engine             = "aurora-postgresql"
  db_engine_version     = "13.6"
  master_username       = "adminprod4"
  master_password       = "securePasswordCentral1"
  database_name         = "prodglobaldb4"

  backup_vault_name     = "prod-backup-vault-central-1"
  backup_iam_role_arn   = "arn:aws:iam::987654321114:role/aws-backup-prod-central-1"
  iam_role_name         = "rds-backup-role-prod-central-1"
}


