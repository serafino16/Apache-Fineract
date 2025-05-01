variable "aws_provider" {
  description = "AWS provider configuration"
  type        = any  # This can be any object type, depending on the provider structure
}
variable "alb_name" {
  description = "Name of the ALB"
  type        = string
  default     = "prod-alb"
}

variable "alb_internal" {
  description = "Whether the ALB is internal or internet-facing"
  type        = bool
  default     = false
}

variable "alb_security_groups" {
  description = "List of security group IDs to associate with ALB"
  type        = list(string)
}

variable "alb_subnets" {
  description = "List of subnet IDs for ALB"
  type        = list(string)
}

variable "alb_enable_deletion_protection" {
  description = "Whether to enable deletion protection on ALB"
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
  default     = 80
}

variable "target_group_protocol" {
  description = "Protocol for Target Group"
  type        = string
  default     = "HTTP"
}

variable "vpc_id" {
  description = "VPC ID where Target Group exists"
  type        = string
}

variable "health_check_protocol" {
  description = "Protocol for health checks"
  type        = string
  default     = "HTTP"
}

variable "health_check_port" {
  description = "Port for health checks"
  type        = string
  default     = "80"
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
  default     = "HTTP"
}

variable "common_tags" {
  description = "Common tags for ALB and Target Group"
  type        = map(string)
}
