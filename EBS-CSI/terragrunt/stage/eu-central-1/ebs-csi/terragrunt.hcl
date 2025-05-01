inputs = {
  cluster_name  = "stage-eks-cluster-eu-central-1"
  iam_role_name = "stage-ebs-csi-role-eu-central-1"
  tags = {
    Environment = "stage"
    Region      = "eu-central-1"
    Owner       = "DevOps Team"
  }
}
