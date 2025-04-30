variable "description" {
  default = "Transit Gateway"
}

variable "vpcs" {
  description = "Map of VPCs to attach to the Transit Gateway"
  type = map(object({
    vpc_id     = string
    subnet_ids = list(string)
    provider   = string
  }))
}

variable "destination_cidr_block" {
  default = "10.0.0.0/8"
}
