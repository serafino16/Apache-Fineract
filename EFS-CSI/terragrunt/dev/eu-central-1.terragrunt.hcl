include {
  path = find_in_parent_folders()
}

terraform {
  source = "../../../../modules/ebs"
}

inputs = {
  cluster_name      = "eks-dev-eu-central-1"
  iam_role_name     = "ebs-csi-driver-dev-eu-central-1"
  availability_zone = "eu-central-1a"
  size              = 50
  type              = "gp3"
  encrypted         = true
  kms_key_id        = "arn:aws:kms:eu-central-1:123456789012:key/abc123"
  iops              = 1000
  throughput        = 125
  snapshot_id       = null
  multi_attach_enabled = false
  tags = {
    "Environment" = "dev"
    "Region"      = "eu-central-1"
    "Cluster"     = "eks-dev-eu-central-1"
  }
  name = "ebs-volume-dev-eu-central-1"
}
