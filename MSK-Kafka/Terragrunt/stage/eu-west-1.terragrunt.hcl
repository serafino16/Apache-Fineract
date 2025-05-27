include {
  path = find_in_parent_folders()
}

terraform {
  source = "../../../../modules/msk-cluster"
}

inputs = {
  cluster_name           = "msk-stage-eu-west-1"
  kafka_version          = "3.5.1"
  number_of_broker_nodes = 2
  instance_type          = "kafka.m5.large"
  ebs_volume_size        = 50
  client_subnets         = [
    "subnet-0a1b2c3d4e5f67891",
    "subnet-0b2c3d4e5f67892a1"
  ]
  security_groups        = ["sg-0a1b2c3d4e5f67891"]
  enhanced_monitoring    = "PER_BROKER"
  tags = {
    Environment = "stage"
    Region      = "eu-west-1"
    Owner       = "team-kafka"
  }
}
