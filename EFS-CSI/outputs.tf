output "efs_csi_iam_role_arn" {
  description = "ARN of the EFS CSI IAM role."
  value       = aws_iam_role.efs_csi_iam_role.arn
}

output "efs_csi_addon_name" {
  description = "Name of the EKS addon for EFS CSI Driver."
  value       = aws_eks_addon.efs_csi_addon.addon_name
}
