output "cluster_name" {
  description = "Name of the EKS cluster."
  value       = aws_eks_cluster.this.name
}

output "cluster_endpoint" {
  description = "Endpoint for the EKS Kubernetes API server."
  value       = aws_eks_cluster.this.endpoint
}

output "cluster_arn" {
  description = "ARN of the EKS cluster."
  value       = aws_eks_cluster.this.arn
}

output "cluster_certificate_authority" {
  description = "Base64 encoded certificate data required to communicate with the cluster."
  value       = aws_eks_cluster.this.certificate_authority[0].data
}

output "cluster_version" {
  description = "Kubernetes version of the cluster."
  value       = aws_eks_cluster.this.version
}

output "iam_role_name" {
  description = "IAM role name used for EKS cluster."
  value       = aws_iam_role.eks_master_role.name
}

output "iam_role_arn" {
  description = "IAM role ARN used for EKS cluster."
  value       = aws_iam_role.eks_master_role.arn
}
