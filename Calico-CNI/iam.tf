# modules/calico/iam.tf
resource "aws_iam_policy" "calico_policy" {
  name        = "CalicoPolicy"
  description = "Policy for Calico CNI (Typha, Operator)"
  policy      = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "ec2:DescribeInstances",
          "ec2:DescribeTags",
          "ec2:DescribeNetworkInterfaces"
        ],
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_role" "calico_irsa" {
  name = "calico-irsa"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Federated = var.eks_oidc_provider_arn
        },
        Action = "sts:AssumeRoleWithWebIdentity",
        Condition = {
          StringEquals = {
            "${replace(var.eks_oidc_provider_url, "https://", "")}:sub" = "system:serviceaccount:kube-system:calico-node"
          }
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "calico_attach" {
  role       = aws_iam_role.calico_irsa.name
  policy_arn = aws_iam_policy.calico_policy.arn
}
