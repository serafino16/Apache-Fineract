include {
  path = find_in_parent_folders()
}

terraform {
  source = "../../../../modules/msk-cluster"
}

inputs = {
  cluster_name           = "msk-stage-eu-central-1"
  kafka_version          = "3.5.1"
  number_of_broker_nodes = 2
  instance_type          = "kafka.m5.large"
  ebs_volume_size        = 50
  client_subnets         = [
    "subnet-0abc123def456gh78",
    "subnet-0bcd234ef567hi89a"
  ]
  security_groups        = ["sg-0abc123def456gh78"]
  enhanced_monitoring    = "PER_BROKER"
  tags = {
    Environment = "stage"
    Region      = "eu-central-1"
    Owner       = "team-kafka"
  }
}
