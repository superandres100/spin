provider "aws" {
  region = var.region
  access_key = var.access_key
  secret_key = var.secret_key
}

// --- Public Subnets ---
resource "aws_subnet" "public_subnets" {

  for_each = var.public_subnets_map
  vpc_id = var.vpc_id
  availability_zone = each.key
  cidr_block = cidrsubnet(var.cidr_block, var.subnets_bit_length, each.value)
  map_public_ip_on_launch = true
  tags = {
    Name = format("Public subnet %s", each.value)
  }
}

// --- Routes ---
resource "aws_route_table" "public_subnet_rtb" {
  vpc_id = var.vpc_id
  tags = {
    Name = "Public Subnets Route Table"
  }
}
resource "aws_route" "vpc_internet_access" {
  route_table_id = aws_route_table.public_subnet_rtb.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = var.igw_id
}
resource "aws_route_table_association" "public_rtb_to_public_subnets" {
  for_each = { for public_subnet in aws_subnet.public_subnets : public_subnet.cidr_block => public_subnet.id }
  route_table_id = aws_route_table.public_subnet_rtb.id
  subnet_id = each.value
}

resource "aws_vpc_endpoint" "gwlb_endpoint" {
  depends_on = [aws_subnet.public_subnets]
  vpc_id = var.vpc_id
  vpc_endpoint_type = "GatewayLoadBalancer"
  service_name = var.service_name
  for_each = { for public_subnet in aws_subnet.public_subnets : public_subnet.cidr_block => public_subnet.id }
  subnet_ids = [each.value]
  tags = {
    "Name" = "gwlb_endpoint"
  }
}
