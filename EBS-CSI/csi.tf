resource "aws_iam_role" "ebs_csi_role" {
  name               = var.iam_role_name
  assume_role_policy = data.aws_iam_policy_document.ebs_csi_assume_role_policy.json

  tags = var.tags
}

data "aws_iam_policy_document" "ebs_csi_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["eks.amazonaws.com"]
    }
  }
}

resource "aws_iam_role_policy_attachment" "ebs_csi_policy_attachment" {
  role       = aws_iam_role.ebs_csi_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"
}

resource "aws_eks_addon" "ebs_csi_addon" {
  cluster_name                = var.cluster_name
  addon_name                  = "aws-ebs-csi-driver"
  service_account_role_arn    = aws_iam_role.ebs_csi_role.arn

  tags = var.tags

  depends_on = [aws_iam_role_policy_attachment.ebs_csi_policy_attachment]
}
