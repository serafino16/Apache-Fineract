variable "cluster_name" {
  description = "Name of the EKS cluster."
  type        = string
}

variable "iam_role_name" {
  description = "Name of the IAM role for EBS CSI driver."
  type        = string
}

variable "tags" {
  description = "Tags to apply to all resources."
  type        = map(string)
  default     = {}
}
