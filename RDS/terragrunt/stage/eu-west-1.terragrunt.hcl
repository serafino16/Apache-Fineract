terraform {
  source = "git::https://github.com/your-repo.git//modules/rds?ref=v1.0"
}

provider "aws" {
  alias  = "eu-west-2"
  region = "eu-west-1"
}

inputs = {
  project_name    = "apache-fineract-project"
  environment     = "stage"
  cluster_name    = "stage-cluster-west-1"

  public_subnet_ids  = ["subnet-0a12bc34", "subnet-1b23de45"]
  private_subnet_ids = ["subnet-3d45fg67", "subnet-4e56gh78"]
  node_instance_types = ["t3.medium", "t3.large"]
  node_desired_size = 4
  node_max_size = 6
  node_min_size = 3
  node_disk_size = 30
  ssh_key_name = "stage-ssh-key-west-1"

  db_cluster_identifier = "global-db-cluster-west-1"
  db_instance_class     = "db.t3.medium"
  db_engine             = "aurora-mysql"
  db_engine_version     = "5.7"
  master_username       = "admin-west-1"
  master_password       = "adminwest1password"
  database_name         = "globaldb-west-1"

  backup_vault_name    = "stage-backup-vault-west-1"
  backup_iam_role_arn  = "arn:aws:iam::987654321012:role/aws-backup-role-west-1"
  iam_role_name        = "rds-backup-role-west-1"
}