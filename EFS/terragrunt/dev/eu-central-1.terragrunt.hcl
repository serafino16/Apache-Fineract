include {
  path = find_in_parent_folders()
}

terraform {
  source = "../../../../modules/efs"
}

inputs = {
  regions        = ["eu-central-1"]
  primary_region = "eu-central-1"
  efs_replication = false
  common_tags = {
    Project     = "apache-fineract"
    Environment = "dev"
    ManagedBy   = "terraform"
  }
}
