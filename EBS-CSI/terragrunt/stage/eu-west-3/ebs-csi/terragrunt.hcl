inputs = {
  cluster_name  = "stage-eks-cluster-eu-west-3"
  iam_role_name = "stage-ebs-csi-role-eu-west-3"
  tags = {
    Environment = "stage"
    Region      = "eu-west-3"
    Owner       = "DevOps Team"
  }
}
