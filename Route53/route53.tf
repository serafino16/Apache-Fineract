
resource "aws_route53_zone" "this" {
  count = var.create_zone ? 1 : 0

  name = var.zone_name
  comment = var.zone_comment
  force_destroy = var.force_destroy

  vpc {
    for_each = var.vpc_associations
    vpc_id  = each.value.vpc_id
    vpc_region = each.value.vpc_region
  }

  tags = var.tags
}

resource "aws_route53_health_check" "this" {
  for_each = { for k, v in var.health_checks : k => v if var.create_health_checks }

  fqdn              = each.value.fqdn
  port              = each.value.port
  type              = each.value.type
  resource_path     = each.value.resource_path
  failure_threshold = each.value.failure_threshold
  request_interval  = each.value.request_interval

  tags = var.tags
}

resource "aws_route53_record" "failover" {
  for_each = { for k, v in var.failover_records : k => v if var.create_failover_records }

  zone_id = aws_route53_zone.this[0].zone_id
  name    = each.value.name
  type    = each.value.type

  set_identifier = each.value.set_identifier
  failover       = each.value.failover

  ttl     = each.value.ttl
  records = each.value.records

  health_check_id = each.value.health_check_id

  depends_on = [aws_route53_zone.this]
}

resource "aws_route53_record" "geolocation" {
  for_each = { for k, v in var.geolocation_records : k => v if var.create_geolocation_records }

  zone_id = aws_route53_zone.this[0].zone_id
  name    = each.value.name
  type    = each.value.type

  set_identifier = each.value.set_identifier

  geolocation_routing_policy {
    continent   = try(each.value.continent, null)
    country     = try(each.value.country, null)
    subdivision = try(each.value.subdivision, null)
  }

  ttl     = each.value.ttl
  records = each.value.records

  depends_on = [aws_route53_zone.this]
}

