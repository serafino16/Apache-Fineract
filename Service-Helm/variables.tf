
variable "eks_cluster_name" {
  type = string
}

variable "iam_role_name" {
  type = string
}

variable "iam_policy_arn" {
  type = string
  default = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}

variable "namespace" {
  type    = string
  default = "apache-fineract"
}

variable "storage_class_name" {
  type    = string
  default = "efs-sc"
}