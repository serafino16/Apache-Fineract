output "zone_id" {
  value       = aws_route53_zone.this[0].zone_id
  description = "ID of the created zone"
  condition   = var.create_zone
}
