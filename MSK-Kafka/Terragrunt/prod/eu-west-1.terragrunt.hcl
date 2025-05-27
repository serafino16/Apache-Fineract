include {
  path = find_in_parent_folders()
}

terraform {
  source = "../../../../modules/msk-cluster"
}

inputs = {
  cluster_name           = "msk-prod-eu-west-1"
  kafka_version          = "3.5.1"
  number_of_broker_nodes = 3
  instance_type          = "kafka.m5.large"
  ebs_volume_size        = 100
  client_subnets         = [
    "subnet-0a1b2c3d4e5f67891", # az1
    "subnet-0b2c3d4e5f67892a1", # az2
    "subnet-0c3d4e5f67893a1b2"  # az3
  ]
  security_groups        = ["sg-0a1b2c3d4e5f67891"]
  enhanced_monitoring    = "PER_BROKER"
  tags = {
    Environment = "prod"
    Region      = "eu-west-1"
    Owner       = "team-kafka"
  }
}
