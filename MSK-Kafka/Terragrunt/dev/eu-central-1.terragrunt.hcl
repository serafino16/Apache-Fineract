include {
  path = find_in_parent_folders()
}

terraform {
  source = "../../../../modules/msk-cluster"
}

inputs = {
  cluster_name           = "msk-dev-eu-central-1"
  kafka_version          = "3.5.1"
  number_of_broker_nodes = 2
  instance_type          = "kafka.t3.small" 
  ebs_volume_size        = 20               
  client_subnets         = [
    "subnet-07f9e8d1abc123456",  
    "subnet-05f1a2b3def456789"
  ]
  security_groups        = ["sg-0987abcde6543210f"]
  enhanced_monitoring    = "DEFAULT"
  tags = {
    Environment = "dev"
    Region      = "eu-central-1"
    Owner       = "devops-team"
    Project     = "kafka-msk"
  }
}
