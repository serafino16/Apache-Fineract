resource "aws_ec2_transit_gateway" "this" {
  description                     = var.description
  amazon_side_asn                = var.amazon_side_asn
  auto_accept_shared_attachments = var.auto_accept
  default_route_table_association = var.default_route_table_association
  default_route_table_propagation = var.default_route_table_propagation
  dns_support                    = var.dns_support
  vpn_ecmp_support               = var.vpn_ecmp_support
  tags                           = var.tags
}

resource "aws_ec2_transit_gateway_route_table" "this" {
  count             = var.create_route_table ? 1 : 0
  transit_gateway_id = aws_ec2_transit_gateway.this.id
  tags               = var.tags
}

resource "aws_ec2_transit_gateway_vpc_attachment" "this" {
  for_each             = var.vpc_attachments
  subnet_ids           = each.value.subnet_ids
  transit_gateway_id   = aws_ec2_transit_gateway.this.id
  vpc_id               = each.value.vpc_id
  appliance_mode_support = lookup(each.value, "appliance_mode_support", "disable")
  dns_support          = lookup(each.value, "dns_support", "enable")
  ipv6_support         = lookup(each.value, "ipv6_support", "disable")
  tags                 = merge(var.tags, each.value.tags)
}

resource "aws_ec2_transit_gateway_route_table_association" "this" {
  for_each = var.create_associations ? aws_ec2_transit_gateway_vpc_attachment.this : {}
  transit_gateway_attachment_id = each.value.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.this[0].id
}

resource "aws_ec2_transit_gateway_route_table_propagation" "this" {
  for_each = var.create_propagations ? aws_ec2_transit_gateway_vpc_attachment.this : {}
  transit_gateway_attachment_id = each.value.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.this[0].id
}


