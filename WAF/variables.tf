variable "waf_environments" {
  description = "Map of environments to create WAFs for. Format: { env_name = { region = ..., alb_arn = ..., enable = true/false } }"
  type = map(object({
    region   = string
    alb_arn  = string
    enable   = bool
  }))
}

variable "common_tags" {
  description = "Common tags for all resources"
  type        = map(string)
  default     = {}
}
