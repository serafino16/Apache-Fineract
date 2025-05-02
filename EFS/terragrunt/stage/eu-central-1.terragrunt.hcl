include {
  path = find_in_parent_folders()
}

terraform {
  source = "../../../../modules/efs"
}

inputs = {
  regions        = ["eu-west-1", "eu-central-1"]
  primary_region = "eu-central-1"
  efs_replication = true
  common_tags = {
    Project     = "apache-fineract"
    Environment = "stage"
    ManagedBy   = "terraform"
  }
}
