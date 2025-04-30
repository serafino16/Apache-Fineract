output "eks_addon_name" {
  description = "Name of the EKS addon."
  value       = aws_eks_addon.ebs_csi_addon.addon_name
}

output "eks_addon_arn" {
  description = "ARN of the EKS addon."
  value       = aws_eks_addon.ebs_csi_addon.arn
}

output "iam_role_arn" {
  description = "ARN of the created EBS CSI IAM role."
  value       = aws_iam_role.ebs_csi_role.arn
}

output "iam_role_name" {
  description = "Name of the EBS CSI IAM role."
  value       = aws_iam_role.ebs_csi_role.name
}
