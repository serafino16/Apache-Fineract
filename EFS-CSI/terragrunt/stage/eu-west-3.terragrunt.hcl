include {
  path = find_in_parent_folders()
}

terraform {
  source = "../../../../modules/ebs"
}

inputs = {
  cluster_name      = "eks-stage-eu-west-3"
  iam_role_name     = "ebs-csi-driver-stage-eu-west-3"
  availability_zone = "eu-west-3a"
  size              = 100
  type              = "gp3"
  encrypted         = true
  kms_key_id        = "arn:aws:kms:eu-west-3:123456789012:key/abc123"
  iops              = 3000
  throughput        = 125
  snapshot_id       = null
  multi_attach_enabled = false
  tags = {
    "Environment" = "stage"
    "Region"      = "eu-west-3"
    "Cluster"     = "eks-stage-eu-west-3"
  }
  name = "ebs-volume-stage-eu-west-3"
}
