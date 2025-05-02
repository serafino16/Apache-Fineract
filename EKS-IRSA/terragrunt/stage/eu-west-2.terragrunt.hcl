include {
  path = find_in_parent_folders()
}

locals {
  region = "eu-west-2"
}

terraform {
  source = "../../../../modules/iam-service-account"
}

inputs = {
  cluster_name                   = "fineract-stage-eu-west-2"
  eks_oidc_url                   = "https://oidc.eks.eu-west-2.amazonaws.com/id/stage5678efgh"
  eks_oidc_root_ca_thumbprint   = "9e99a48a9960b14926bb7f3b02e22da0c54ce9ae"
  kubernetes_namespace          = "fineract"
  service_account_name          = "efs-controller"
  policy_arn                    = "arn:aws:iam::aws:policy/AmazonEFSCSIDriverPolicy"
  tags = {
    Project     = "apache-fineract"
    Environment = "stage"
    Region      = "eu-west-2"
  }
}
