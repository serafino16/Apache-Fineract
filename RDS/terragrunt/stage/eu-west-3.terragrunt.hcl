terraform {
  source = "git::https://github.com/your-repo.git//modules/rds?ref=v1.0"
}

provider "aws" {
  alias  = "eu-west-1"
  region = "eu-west-3"
}

inputs = {
  project_name    = "stage-project"
  environment     = "stage"
  cluster_name    = "stage-cluster-west-3"

  public_subnet_ids  = ["subnet-1a23bc45", "subnet-2b34de56"]
  private_subnet_ids = ["subnet-4d45fg67", "subnet-5e56gh78"]
  node_instance_types = ["t3.medium", "t3.large"]
  node_desired_size = 4
  node_max_size = 6
  node_min_size = 3
  node_disk_size = 30
  ssh_key_name = "stage-ssh-key-west-3"

  db_cluster_identifier = "global-db-cluster-west-3"
  db_instance_class     = "db.t3.medium"
  db_engine             = "aurora-mysql"
  db_engine_version     = "5.7"
  master_username       = "admin-west-3"
  master_password       = "adminwest3password"
  database_name         = "globaldb-west-3"

  backup_vault_name    = "stage-backup-vault-west-3"
  backup_iam_role_arn  = "arn:aws:iam::987654321012:role/aws-backup-role-west-3"
  iam_role_name        = "rds-backup-role-west-3"
}
