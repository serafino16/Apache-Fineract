terraform {
  source = "git::https://github.com/your-repo.git//modules/rds?ref=v1.0"
}

provider "aws" {
  alias  = "eu-west-1"
  region = "eu-west-2"
}

inputs = {
  project_name    = "stage-project"
  environment     = "stage"
  cluster_name    = "stage-cluster-west-2"

  public_subnet_ids  = ["subnet-2a34bc56", "subnet-3b45de67"]
  private_subnet_ids = ["subnet-5d56fg78", "subnet-6e67gh89"]
  node_instance_types = ["t3.medium", "t3.large"]
  node_desired_size = 4
  node_max_size = 6
  node_min_size = 3
  node_disk_size = 30
  ssh_key_name = "stage-ssh-key-west-2"

  db_cluster_identifier = "global-db-cluster-west-2"
  db_instance_class     = "db.t3.medium"
  db_engine             = "aurora-mysql"
  db_engine_version     = "5.7"
  master_username       = "admin-west-2"
  master_password       = "adminwest2password"
  database_name         = "globaldb-west-2"

  backup_vault_name    = "stage-backup-vault-west-2"
  backup_iam_role_arn  = "arn:aws:iam::987654321012:role/aws-backup-role-west-2"
  iam_role_name        = "rds-backup-role-west-2"
}