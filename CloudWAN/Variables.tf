variable "description" {
  type        = string
  description = "Description for the Core Network"
}

variable "global_description" {
  type        = string
  description = "Description for the Global Network"
}

variable "tags" {
  type    = map(string)
  default = {}
}
