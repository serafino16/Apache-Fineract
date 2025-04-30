variable "provider" {
  description = "AWS provider alias to use (e.g., aws.dev, aws.prod)"
  type        = any
}

variable "environment" {
  description = "Environment (e.g., dev, prod)"
  type        = string
}

variable "subnet_group_name" {
  description = "Name of the Redis subnet group"
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs for Redis subnet group"
  type        = list(string)
}

variable "vpc_id" {
  description = "VPC ID for Redis security group"
  type        = string
}

variable "allowed_cidr" {
  description = "CIDR block allowed to access Redis"
  type        = string
}

variable "replication_group_id" {
  description = "Redis replication group ID"
  type        = string
}

variable "replication_group_description" {
  description = "Description for the Redis replication group"
  type        = string
}

variable "engine_version" {
  description = "Redis engine version"
  type        = string
  default     = "6.x"
}

variable "node_type" {
  description = "Redis node instance type"
  type        = string
}

variable "number_of_cache_clusters" {
  description = "Number of Redis cache clusters"
  type        = number
}

variable "automatic_failover_enabled" {
  description = "Enable automatic failover"
  type        = bool
  default     = true
}

variable "preferred_cache_cluster_azs" {
  description = "List of preferred availability zones for clusters"
  type        = list(string)
}

variable "snapshot_retention_limit" {
  description = "Number of days to retain Redis snapshots"
  type        = number
}

variable "snapshot_window" {
  description = "Time window for snapshot"
  type        = string
}

variable "global_replication_group_id" {
  description = "Optional: ID of Global Datastore for replication (for backup clusters)"
  type        = string
  default     = null
}
