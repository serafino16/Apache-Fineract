include {
  path = find_in_parent_folders()
}

terraform {
  source = "../../../../modules/ebs"
}

inputs = {
  availability_zone    = "eu-west-2a"
  size                 = 100
  type                 = "gp3"
  encrypted            = true
  kms_key_id           = "arn:aws:kms:eu-west-2:123456789012:key/abc123"
  iops                 = 3000
  throughput           = 125
  snapshot_id          = null
  multi_attach_enabled = false
  tags = {
    "Environment" = "stage"
    "Region"      = "eu-west-2"
  }
  name = "ebs-volume-stage-eu-west-2"
}
