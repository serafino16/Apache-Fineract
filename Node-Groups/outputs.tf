output "public_node_group_name" {
  description = "Name of the public EKS Node Group."
  value       = aws_eks_node_group.public_nodes.node_group_name
}

output "private_node_group_name" {
  description = "Name of the private EKS Node Group."
  value       = aws_eks_node_group.private_nodes.node_group_name
}

output "node_role_name" {
  description = "IAM role name used for the node groups."
  value       = aws_iam_role.node_group_role.name
}

output "node_role_arn" {
  description = "IAM role ARN used for the node groups."
  value       = aws_iam_role.node_group_role.arn
}
