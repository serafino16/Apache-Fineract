variable "project_name" {
  description = "Name of the project."
  type        = string
}

variable "environment" {
  description = "Environment (e.g., stage, prod, prod-backup)."
  type        = string
}

variable "cluster_version" {
  description = "Kubernetes version for the EKS cluster."
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs for the EKS cluster."
  type        = list(string)
}

variable "endpoint_private_access" {
  description = "Enable private access to the EKS cluster endpoint."
  type        = bool
  default     = true
}

variable "endpoint_public_access" {
  description = "Enable public access to the EKS cluster endpoint."
  type        = bool
  default     = true
}

variable "public_access_cidrs" {
  description = "List of CIDR blocks allowed access to the public endpoint."
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "service_ipv4_cidr" {
  description = "IPv4 CIDR block for Kubernetes services."
  type        = string
}

variable "enabled_cluster_log_types" {
  description = "List of EKS control plane logs to enable."
  type        = list(string)
  default     = ["api", "audit", "authenticator", "controllerManager", "scheduler"]
}
