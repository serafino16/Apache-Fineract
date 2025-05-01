include {
  path = find_in_parent_folders()
}

terraform {
  source = "git::git@github.com:your-org/ebs-csi-module.git//?ref=v1.0.0"
}

inputs = {
  cluster_name  = "stage-eks-cluster-eu-west-1"
  iam_role_name = "stage-ebs-csi-role-eu-west-1"
  tags = {
    Environment = "stage"
    Region      = "eu-west-1"
    Owner       = "DevOps Team"
  }
}
