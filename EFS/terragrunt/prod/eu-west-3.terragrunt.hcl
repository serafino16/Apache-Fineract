include {
  path = find_in_parent_folders()
}

terraform {
  source = "../../../../modules/efs"
}

inputs = {
  regions        = ["eu-west-1", "eu-west-3"]
  primary_region = "eu-west-3"
  efs_replication = true
  common_tags = {
    Project     = "apache-fineract"
    Environment = "production"
    ManagedBy   = "terraform"
  }
}
