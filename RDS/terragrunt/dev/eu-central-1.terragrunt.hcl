terraform {
  source = "git::https://github.com/your-repo.git//modules/rds?ref=v1.0"
}

provider "aws" {
  alias  = "dev"
  region = "eu-central-1"
}

inputs = {
  project_name = "dev-project"
  environment  = "dev"
  cluster_name = "dev-cluster"
  
  public_subnet_ids = ["subnet-12345678", "subnet-23456789"]
  private_subnet_ids = ["subnet-34567890", "subnet-45678901"]
  node_instance_types = ["t3.medium"]
  node_desired_size = 3
  node_max_size = 5
  node_min_size = 2
  node_disk_size = 20
  ssh_key_name = "dev-ssh-key"

  db_cluster_identifier = "global-db-cluster-dev"
  db_instance_class = "db.t3.medium"
  db_engine = "aurora-mysql"
  db_engine_version = "5.7"
  master_username = "admin"
  master_password = "admin1234"
  database_name = "globaldb-dev"

  backup_vault_name = "dev-backup-vault"
  backup_iam_role_arn = "arn:aws:iam::123456789012:role/aws-backup-role"
  iam_role_name = "rds-backup-role"
}