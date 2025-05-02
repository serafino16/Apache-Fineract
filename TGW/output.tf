output "transit_gateway_id" {
  value = aws_ec2_transit_gateway.this.id
}

output "route_table_id" {
  value = try(aws_ec2_transit_gateway_route_table.this[0].id, null)
}

output "vpc_attachment_ids" {
  value = { for k, v in aws_ec2_transit_gateway_vpc_attachment.this : k => v.id }
}

output "peering_attachment_ids" {
  value = { for k, v in aws_ec2_transit_gateway_peering_attachment.this : k => v.id }
}

