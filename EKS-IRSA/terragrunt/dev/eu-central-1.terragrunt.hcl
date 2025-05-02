terraform {
  source = "git::https://github.com/your-org/your-modules.git//iam-service-account?ref=main"
}

locals {
  environment = "dev"
  region      = "eu-central-1"
}

inputs = {
  cluster_name                  = "fineract-eks-dev-eu-central-1"
  eks_oidc_url                  = "https://oidc.eks.eu-central-1.amazonaws.com/id/EXAMPLEDEV1234567890"
  eks_oidc_root_ca_thumbprint  = "9e99a48a9960b14926bb7f3b02e22da0afd10df6"
  kubernetes_namespace         = "default"
  service_account_name         = "fineract-service-account"
  policy_arn                   = "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"

  tags = {
   tags = {
    Project     = "apache-fineract"
    Environment = "dev"
    Region      = "eu-central-1"
  }
}
