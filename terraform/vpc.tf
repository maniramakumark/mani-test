resource "aws_vpc" "example_vpc" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_support   = true
  enable_dns_hostnames = true
}

resource "aws_internet_gateway" "example_ig" {
  vpc_id = aws_vpc.example_vpc.id
}

resource "aws_subnet" "public_subnets" {
  count = length(var.public_subnets_cidr_blocks)

  vpc_id     = aws_vpc.example_vpc.id
  cidr_block = var.public_subnets_cidr_blocks[count.index]
  availability_zone = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch = true
}

resource "aws_subnet" "private_subnets" {
  count = length(var.private_subnets_cidr_blocks)

  vpc_id     = aws_vpc.example_vpc.id
  cidr_block = var.private_subnets_cidr_blocks[count.index]
  availability_zone = data.aws_availability_zones.available.names[count.index]
}


resource "aws_eip" "example_nat_gateway_eip" {
  vpc        = true
  depends_on = [aws_internet_gateway.example_ig]
}

resource "aws_nat_gateway" "example_nat_gateway" {
  allocation_id = aws_eip.example_nat_gateway_eip.id
  subnet_id     = element(aws_subnet.public_subnets.*.id, 0)
  depends_on = [aws_eip.example_nat_gateway_eip]
}

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.example_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id  = aws_internet_gateway.example_ig.id
  }
}

resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.example_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id  = aws_nat_gateway.example_nat_gateway.id
  }
}

resource "aws_route_table_association" "public_subnet_association" {
  count          = length(var.public_subnets_cidr_blocks)
  subnet_id      = aws_subnet.public_subnets[count.index].id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table_association" "private_subnet_association" {
  count          = length(var.private_subnets_cidr_blocks)
  subnet_id      = aws_subnet.private_subnets[count.index].id
  route_table_id = aws_route_table.private_route_table.id
}
