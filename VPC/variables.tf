variable "vpc_name" {
  description = "Name of the VPC."
  type        = string
}

variable "cidr_block" {
  description = "CIDR block for the VPC."
  type        = string
}

variable "azs" {
  description = "List of availability zones to create subnets in."
  type        = list(string)
}

variable "public_subnets" {
  description = "List of public subnet CIDRs."
  type        = list(string)
}

variable "private_subnets" {
  description = "List of private subnet CIDRs."
  type        = list(string)
}

variable "tags" {
  description = "Tags to apply to all resources."
  type        = map(string)
  default     = {}
}
