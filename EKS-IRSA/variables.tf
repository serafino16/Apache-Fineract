variable "cluster_name" {
  description = "EKS cluster name."
  type        = string
}

variable "eks_oidc_url" {
  description = "OIDC URL from the EKS cluster (example: https://oidc.eks.eu-west-1.amazonaws.com/id/EXAMPLED539D4633E53DE1B716D3041E)"
  type        = string
}

variable "eks_oidc_root_ca_thumbprint" {
  description = "Root CA Thumbprint for the EKS OIDC provider."
  type        = string
}

variable "kubernetes_namespace" {
  description = "Kubernetes namespace where service account lives."
  type        = string
}

variable "service_account_name" {
  description = "Kubernetes service account name to associate with this IAM Role."
  type        = string
}

variable "policy_arn" {
  description = "IAM Policy ARN to attach to the role (example: AmazonS3ReadOnlyAccess)"
  type        = string
}

variable "tags" {
  description = "Tags to apply to resources."
  type        = map(string)
  default     = {}
}
