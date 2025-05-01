inputs = {
  cluster_name  = "prod-eks-cluster-eu-west-2"
  iam_role_name = "prod-ebs-csi-role-eu-west-2"
  tags = {
    Environment = "prod"
    Region      = "eu-west-2"
    Owner       = "DevOps Team"
  }
}
