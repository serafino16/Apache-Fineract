output "global_accelerator_arn" {
  value = aws_globalaccelerator_accelerator.main.id
}

output "global_accelerator_ip_addresses" {
  value = aws_globalaccelerator_accelerator.main.ip_addresses
}
