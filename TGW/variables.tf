variable "description" {
  type = string
}

variable "amazon_side_asn" {
  type    = number
  default = 64512
}

variable "auto_accept" {
  type    = string
  default = "disable"
}

variable "default_route_table_association" {
  type    = string
  default = "disable"
}

variable "default_route_table_propagation" {
  type    = string
  default = "disable"
}

variable "dns_support" {
  type    = string
  default = "enable"
}

variable "vpn_ecmp_support" {
  type    = string
  default = "enable"
}

variable "tags" {
  type    = map(string)
  default = {}
}

variable "create_route_table" {
  type    = bool
  default = true
}

variable "create_associations" {
  type    = bool
  default = true
}

variable "create_propagations" {
  type    = bool
  default = true
}

variable "vpc_attachments" {
  type = map(object({
    vpc_id               = string
    subnet_ids           = list(string)
    appliance_mode_support = optional(string, "disable")
    dns_support          = optional(string, "enable")
    ipv6_support         = optional(string, "disable")
    tags                 = map(string)
  }))
  default = {}
}

variable "peering_attachments" {
  type = map(object({
    peer_account_id         = string
    peer_region             = string
    peer_tgw_id             = string
    tags                    = map(string)
  }))
  default = {}
}
