output "core_network_id" {
  value = aws_networkmanager_core_network.this.id
}

output "global_network_id" {
  value = aws_networkmanager_global_network.this.id
}
