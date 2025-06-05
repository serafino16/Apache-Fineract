output "firewall_id" {
  description = "ID of the Network Firewall"
  value       = aws_networkfirewall_firewall.this.id
}

output "firewall_policy_arn" {
  description = "ARN of the firewall policy"
  value       = aws_networkfirewall_firewall_policy.this.arn
}

output "firewall_arn" {
  description = "ARN of the Network Firewall"
  value       = aws_networkfirewall_firewall.this.arn
}

output "firewall_name" {
  description = "Name of the Network Firewall"
  value       = aws_networkfirewall_firewall.this.name
}
