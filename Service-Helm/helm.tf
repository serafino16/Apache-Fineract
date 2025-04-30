provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}

provider "kubernetes" {
  config_path = "~/.kube/config"
}

data "aws_caller_identity" "current" {}

data "aws_eks_cluster" "cluster" {
  name = var.eks_cluster_name
}

resource "aws_iam_role" "irsa_iam_role" {
  name = var.iam_role_name

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Federated = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:oidc-provider/${replace(data.aws_eks_cluster.cluster.identity[0].oidc.issuer, "https://", "" )}"
      }
      Action = "sts:AssumeRoleWithWebIdentity"
      Condition = {
        StringEquals = {
          "${replace(data.aws_eks_cluster.cluster.identity[0].oidc.issuer, "https://", "")}:sub" = "system:serviceaccount:apache-fineract:fineract-business-sa"
        }
      }
    }]
  })
}

resource "aws_iam_role_policy_attachment" "irsa_attach" {
  role       = aws_iam_role.irsa_iam_role.name
  policy_arn = var.iam_policy_arn
}

resource "kubernetes_service_account" "fineract_business" {
  metadata {
    name      = "fineract-business-sa"
    namespace = var.namespace
    annotations = {
      "eks.amazonaws.com/role-arn" = aws_iam_role.irsa_iam_role.arn
    }
  }
  depends_on = [aws_iam_role_policy_attachment.irsa_attach]
}

resource "kubernetes_persistent_volume_claim" "efs_pvc" {
  metadata {
    name      = "efs-pvc"
    namespace = var.namespace
  }
  spec {
    access_modes = ["ReadWriteMany"]
    resources {
      requests = {
        storage = "5Gi"
      }
    }
    storage_class_name = var.storage_class_name
  }
}

resource "helm_release" "fineract_business" {
  name             = "fineract-business"
  chart            = "../helm/fineract-business"
  namespace        = var.namespace
  create_namespace = true
  version          = "0.1.0"

  values = [
    file("../helm/fineract-business/values.yaml")
  ]
}
