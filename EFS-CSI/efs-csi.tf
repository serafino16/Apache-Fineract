data "aws_partition" "current" {}

resource "aws_iam_role" "efs_csi_iam_role" {
  name = "${var.cluster_name}-efs-csi-irsa-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Federated = var.oidc_provider_arn
        }
        Action = "sts:AssumeRoleWithWebIdentity"
        Condition = {
          StringEquals = {
            "${var.oidc_provider_extract_from_arn}:sub" : "system:serviceaccount:kube-system:efs-csi-controller-sa"
          }
        }
      }
    ]
  })

  tags = var.tags
}

resource "aws_iam_role_policy_attachment" "efs_csi_iam_role_policy_attach" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonElasticFileSystemCSIDriverPolicy"
  role       = aws_iam_role.efs_csi_iam_role.name
}

resource "aws_eks_addon" "efs_csi_addon" {
  cluster_name             = var.cluster_name
  addon_name               = "aws-efs-csi-driver"
  service_account_role_arn = aws_iam_role.efs_csi_iam_role.arn

  resolve_conflicts        = "OVERWRITE" 
  tags                     = var.tags

  depends_on = [
    aws_iam_role_policy_attachment.efs_csi_iam_role_policy_attach
  ]
}
