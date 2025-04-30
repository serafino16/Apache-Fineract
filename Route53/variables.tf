variable "create_zone" {
  description = "Whether to create the Route 53 zone"
  type        = bool
  default     = true
}

variable "zone_name" {
  description = "Name of the hosted zone"
  type        = string
}

variable "zone_comment" {
  description = "Comment for the hosted zone"
  type        = string
  default     = null
}

variable "force_destroy" {
  description = "Destroy all records when deleting zone"
  type        = bool
  default     = false
}

variable "vpc_associations" {
  description = "Map of VPCs to associate (for private hosted zones)"
  type = map(object({
    vpc_id     = string
    vpc_region = string
  }))
  default = {}
}

variable "tags" {
  description = "Tags to apply"
  type        = map(string)
  default     = {}
}

variable "create_health_checks" {
  description = "Whether to create health checks"
  type        = bool
  default     = false
}

variable "health_checks" {
  description = "Health checks configuration"
  type = map(object({
    fqdn              = string
    port              = number
    type              = string
    resource_path     = string
    failure_threshold = number
    request_interval  = number
  }))
  default = {}
}

variable "create_failover_records" {
  description = "Whether to create failover DNS records"
  type        = bool
  default     = false
}

variable "failover_records" {
  description = "Failover record configuration"
  type = map(object({
    name            = string
    type            = string
    set_identifier  = string
    failover        = string
    ttl             = number
    records         = list(string)
    health_check_id = optional(string)
  }))
  default = {}
}

variable "create_geolocation_records" {
  description = "Whether to create geolocation records"
  type        = bool
  default     = false
}

variable "geolocation_records" {
  description = "Geolocation record configuration"
  type = map(object({
    name           = string
    type           = string
    set_identifier = string
    ttl            = number
    records        = list(string)
    continent      = optional(string)
    country        = optional(string)
    subdivision    = optional(string)
  }))
  default = {}
}
