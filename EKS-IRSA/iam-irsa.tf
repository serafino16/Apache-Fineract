data "aws_partition" "current" {}

resource "aws_iam_openid_connect_provider" "this" {
  client_id_list  = ["sts.${data.aws_partition.current.dns_suffix}"]
  thumbprint_list = [var.eks_oidc_root_ca_thumbprint]
  url             = var.eks_oidc_url

  tags = merge(
    {
      Name = "${var.cluster_name}-eks-irsa-oidc"
    },
    var.tags
  )
}

resource "aws_iam_role" "this" {
  name = "${var.cluster_name}-irsa-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRoleWithWebIdentity"
        Effect = "Allow"
        Principal = {
          Federated = aws_iam_openid_connect_provider.this.arn
        }
        Condition = {
          StringEquals = {
            "${replace(var.eks_oidc_url, "https://", "")}:sub" = "system:serviceaccount:${var.kubernetes_namespace}:${var.service_account_name}"
          }
        }
      }
    ]
  })

  tags = merge(
    {
      Name = "${var.cluster_name}-irsa-role"
    },
    var.tags
  )
}

resource "aws_iam_role_policy_attachment" "this" {
  role       = aws_iam_role.this.name
  policy_arn = var.policy_arn
}
