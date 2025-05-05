variable "accelerator_name" {
  description = "Name for the Global Accelerator"
  type        = string
}

variable "endpoint_groups" {
  description = "Map of regions and endpoint configurations"
  type = map(object({
    endpoint_id = string
    weight      = number
  }))
}

variable "deletion_protection" {
  description = "Enable deletion protection"
  type        = bool
  default     = false
}

variable "tags" {
  description = "Tags for the Global Accelerator"
  type        = map(string)
  default     = {}
}