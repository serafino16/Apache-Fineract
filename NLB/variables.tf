variable "nlb_name" {
  description = "Name of the NLB"
  type        = string
  default     = "devstage-nlb"
}

variable "nlb_internal" {
  description = "Whether the NLB is internal or internet-facing"
  type        = bool
  default     = false
}

variable "nlb_security_groups" {
  description = "List of security group IDs to associate with NLB"
  type        = list(string)
}

variable "nlb_subnets" {
  description = "List of subnet IDs for NLB"
  type        = list(string)
}

variable "nlb_enable_deletion_protection" {
  description = "Whether to enable deletion protection on NLB"
  type        = bool
  default     = false
}

variable "target_group_name" {
  description = "Name of the Target Group"
  type        = string
}

variable "target_group_port" {
  description = "Port for Target Group"
  type        = number
  default     = 8080
}

variable "target_group_protocol" {
  description = "Protocol for Target Group"
  type        = string
  default     = "TCP"
}

variable "vpc_id" {
  description = "VPC ID where Target Group exists"
  type        = string
}

variable "health_check_protocol" {
  description = "Protocol for health checks"
  type        = string
  default     = "TCP"
}

variable "health_check_port" {
  description = "Port for health checks"
  type        = string
  default     = "8080"
}

variable "health_check_interval" {
  description = "Interval in seconds between health checks"
  type        = number
  default     = 30
}

variable "health_check_timeout" {
  description = "Timeout in seconds for health checks"
  type        = number
  default     = 5
}

variable "health_check_unhealthy_threshold" {
  description = "Number of consecutive failed health checks before unhealthy"
  type        = number
  default     = 2
}

variable "health_check_healthy_threshold" {
  description = "Number of consecutive successful health checks before healthy"
  type        = number
  default     = 2
}

variable "listener_port" {
  description = "Listener port"
  type        = number
  default     = 80
}

variable "listener_protocol" {
  description = "Listener protocol"
  type        = string
  default     = "TCP"
}

variable "common_tags" {
  description = "Common tags for all resources"
  type        = map(string)
}
