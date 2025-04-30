variable "cluster_name" {
  description = "Name of the EKS cluster."
  type        = string
}

variable "oidc_provider_arn" {
  description = "OIDC provider ARN from the EKS cluster (needed for IRSA)."
  type        = string
}

variable "oidc_provider_extract_from_arn" {
  description = "OIDC provider extract (e.g., 'oidc.eks.eu-west-1.amazonaws.com/id/XXXXXXXXXX') for service account mapping."
  type        = string
}

variable "tags" {
  description = "Tags to apply to all resources."
  type        = map(string)
  default     = {}
}
