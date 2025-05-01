inputs = {
  cluster_name  = "stage-eks-cluster-eu-west-2"
  iam_role_name = "stage-ebs-csi-role-eu-west-2"
  tags = {
    Environment = "stage"
    Region      = "eu-west-2"
    Owner       = "DevOps Team"
  }
}
