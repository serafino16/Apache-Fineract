variable "availability_zone" {
  description = "The AZ where the EBS volume will exist."
  type        = string
}

variable "size" {
  description = "Size of the EBS volume in GiBs."
  type        = number
  default     = null
}

variable "type" {
  description = "The type of EBS volume."
  type        = string
  default     = "gp3"
}

variable "encrypted" {
  description = "If true, the disk will be encrypted."
  type        = bool
  default     = true
}

variable "kms_key_id" {
  description = "The ARN for the KMS encryption key."
  type        = string
  default     = null
}

variable "iops" {
  description = "The amount of IOPS to provision for the volume. Only valid for io1, io2, and gp3."
  type        = number
  default     = null
}

variable "throughput" {
  description = "The throughput (MiB/s) to provision for a volume. Only valid for gp3."
  type        = number
  default     = null
}

variable "snapshot_id" {
  description = "The snapshot ID to create the volume from."
  type        = string
  default     = null
}

variable "multi_attach_enabled" {
  description = "Specifies whether to enable Amazon EBS Multi-Attach."
  type        = bool
  default     = false
}

variable "tags" {
  description = "A map of tags to assign to the resource."
  type        = map(string)
  default     = {}
}

variable "name" {
  description = "Name tag for the EBS volume."
  type        = string
  default     = "ebs-volume"
}
