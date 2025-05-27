variable "cluster_name" {
  description = "Name of the MSK cluster"
  type        = string
}

variable "kafka_version" {
  description = "Kafka version to deploy"
  type        = string
}

variable "number_of_broker_nodes" {
  description = "Number of Kafka broker nodes"
  type        = number
}

variable "instance_type" {
  description = "Kafka broker EC2 instance type"
  type        = string
}

variable "ebs_volume_size" {
  description = "Size of EBS volumes for brokers (in GiB)"
  type        = number
}

variable "client_subnets" {
  description = "List of subnet IDs for the MSK brokers"
  type        = list(string)
}

variable "security_groups" {
  description = "List of security group IDs for MSK brokers"
  type        = list(string)
}

variable "enhanced_monitoring" {
  description = "Level of monitoring for the cluster"
  type        = string
  default     = "DEFAULT"
}

variable "tags" {
  description = "Tags to apply to the cluster"
  type        = map(string)
  default     = {}
}
