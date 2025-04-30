resource "aws_ec2_transit_gateway" "this" {
  description = var.description
}

resource "aws_ec2_transit_gateway_vpc_attachment" "attachments" {
  for_each = var.vpcs

  transit_gateway_id = aws_ec2_transit_gateway.this.id
  vpc_id             = each.value.vpc_id
  subnet_ids         = each.value.subnet_ids
  provider           = each.value.provider
}

resource "aws_route_table" "route_tables" {
  for_each = var.vpcs

  vpc_id = each.value.vpc_id
  provider = each.value.provider
}

resource "aws_route" "tgw_routes" {
  for_each = var.vpcs

  route_table_id         = aws_route_table.route_tables[each.key].id
  destination_cidr_block = var.destination_cidr_block
  transit_gateway_id     = aws_ec2_transit_gateway.this.id
  provider               = each.value.provider
}
