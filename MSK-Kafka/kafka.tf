resource "aws_msk_cluster" "this" {
  cluster_name           = var.cluster_name
  kafka_version          = var.kafka_version
  number_of_broker_nodes = var.number_of_broker_nodes

  broker_node_group_info {
    instance_type   = var.instance_type
    ebs_volume_size = var.ebs_volume_size
    client_subnets  = var.client_subnets
    security_groups = var.security_groups
  }

  encryption_info {
    encryption_in_transit {
      client_broker = "TLS"
      in_cluster    = true
    }
  }

  enhanced_monitoring = var.enhanced_monitoring
  tags                = var.tags
}