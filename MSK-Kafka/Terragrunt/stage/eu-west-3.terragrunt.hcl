include {
  path = find_in_parent_folders()
}

terraform {
  source = "../../../../modules/msk-cluster"
}

inputs = {
  cluster_name           = "msk-stage-eu-west-3"
  kafka_version          = "3.5.1"
  number_of_broker_nodes = 2
  instance_type          = "kafka.m5.large"
  ebs_volume_size        = 50
  client_subnets         = [
    "subnet-0f123456789abcde1",
    "subnet-0f23456789bcdef12"
  ]
  security_groups        = ["sg-0f123456789abcde1"]
  enhanced_monitoring    = "PER_BROKER"
  tags = {
    Environment = "stage"
    Region      = "eu-west-3"
    Owner       = "team-kafka"
  }
}
