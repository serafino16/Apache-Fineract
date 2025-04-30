resource "aws_vpc" "this" {
  cidr_block           = var.cidr_block
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = merge(var.tags, {
    Name = var.vpc_name
  })
}

resource "aws_subnet" "public" {
  count = length(var.public_subnets)

  vpc_id     = aws_vpc.this.id
  cidr_block = element(var.public_subnets, count.index)
  availability_zone = element(var.azs, count.index)

  map_public_ip_on_launch = true

  tags = merge(var.tags, {
    Name = "${var.vpc_name}-public-${count.index}"
    Type = "Public Subnet"
  })
}

resource "aws_subnet" "private" {
  count = length(var.private_subnets)

  vpc_id     = aws_vpc.this.id
  cidr_block = element(var.private_subnets, count.index)
  availability_zone = element(var.azs, count.index)

  tags = merge(var.tags, {
    Name = "${var.vpc_name}-private-${count.index}"
    Type = "Private Subnet"
  })
}
