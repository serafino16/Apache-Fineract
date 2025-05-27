include {
  path = find_in_parent_folders()
}

terraform {
  source = "../../../../modules/msk-cluster"
}

inputs = {
  cluster_name           = "msk-stage-eu-west-2"
  kafka_version          = "3.5.1"
  number_of_broker_nodes = 2
  instance_type          = "kafka.m5.large"
  ebs_volume_size        = 50
  client_subnets         = [
    "subnet-01bc23de45fa67891",
    "subnet-02cd34ef56ab78912"
  ]
  security_groups        = ["sg-01bc23de45fa67891"]
  enhanced_monitoring    = "PER_BROKER"
  tags = {
    Environment = "stage"
    Region      = "eu-west-2"
    Owner       = "team-kafka"
  }
}
