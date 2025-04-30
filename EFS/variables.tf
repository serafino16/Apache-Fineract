variable "regions" {
  description = "List of AWS regions for multi-region deployment"
  type        = list(string)
  default     = ["eu-west-1", "eu-west-2", "eu-west-3"]
}

variable "primary_region" {
  description = "Primary region for EFS replication source"
  type        = string
  default     = "eu-west-1"
}

variable "efs_replication" {
  description = "Enable EFS replication (true/false)"
  type        = bool
  default     = true
}

variable "common_tags" {
  description = "Common tags to apply to all resources"
  type        = map(string)
  default = {
    Project     = "spree-commerce"
    Environment = "production"
    ManagedBy   = "terraform"
  }
}
