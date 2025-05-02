terraform {
  source = "git::https://github.com/your-repo.git//modules/rds?ref=v1.0"
}

provider "aws" {
  alias  = "prod-west-2"
  region = "eu-west-2"
}

inputs = {
  project_name          = "prod-project"
  environment           = "prod"
  cluster_name          = "prod-cluster-west-2"

  public_subnet_ids     = ["subnet-08b1ac34", "subnet-14c5bd67"]
  private_subnet_ids    = ["subnet-22e6fe89", "subnet-36f7gf90"]
  node_instance_types   = ["m5.large", "m5.xlarge"]
  node_desired_size     = 6
  node_max_size         = 10
  node_min_size         = 4
  node_disk_size        = 100
  ssh_key_name          = "prod-key-west-2"

  db_cluster_identifier = "prod-global-db-west-2"
  db_instance_class     = "db.m5.large"
  db_engine             = "aurora-postgresql"
  db_engine_version     = "13.6"
  master_username       = "adminprod2"
  master_password       = "securePasswordWest2"
  database_name         = "prodglobaldb2"

  backup_vault_name     = "prod-backup-vault-west-2"
  backup_iam_role_arn   = "arn:aws:iam::987654321112:role/aws-backup-prod-west-2"
  iam_role_name         = "rds-backup-role-prod-west-2"
}
