variable "project_name" {
  description = "Project name to use for resources."
  type        = string
}

variable "environment" {
  description = "Environment (devstage, prod, etc)."
  type        = string
}

variable "cluster_name" {
  description = "Name of the EKS cluster."
  type        = string
}

variable "public_subnet_ids" {
  description = "List of public subnet IDs."
  type        = list(string)
}

variable "private_subnet_ids" {
  description = "List of private subnet IDs."
  type        = list(string)
}

variable "node_instance_types" {
  description = "List of EC2 instance types for the nodes."
  type        = list(string)
  default     = ["t3.medium"]
}

variable "node_desired_size" {
  description = "Desired number of worker nodes."
  type        = number
}

variable "node_max_size" {
  description = "Maximum number of worker nodes."
  type        = number
}

variable "node_min_size" {
  description = "Minimum number of worker nodes."
  type        = number
}

variable "node_disk_size" {
  description = "Disk size for nodes in GB."
  type        = number
  default     = 20
}

variable "ssh_key_name" {
  description = "Name of the SSH key pair to use for node access."
  type        = string
}
