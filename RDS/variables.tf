variable "regions" {
  description = "List of regions to deploy RDS"
  type        = list(string)
}

variable "read_replica_regions" {
  description = "List of regions to deploy RDS read replicas"
  type        = list(string)
  default     = ["eu-west-2"]
}

variable "backup_vault_name" {
  description = "Name of the AWS Backup Vault"
  type        = string
}

variable "backup_iam_role_arn" {
  description = "IAM Role ARN for AWS Backup service to use"
  type        = string
}
variable "iam_role_name" {
  description = "Name of the IAM role for RDS"
  type        = string
}