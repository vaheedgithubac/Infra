# VPC
resource "aws_vpc" "nat_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"

  tags = {
    Name = "nat-instance-vpc"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "nat_igw" {
  vpc_id = aws_vpc.nat_vpc.id

  tags = {
    Name      = "nat-instance-igw"
    Terraform = true
  }
}

# Public subnet 1
resource "aws_subnet" "public" {
  cidr_block        = "10.0.0.0/24" #var.cidr_blocks[3]
  vpc_id            = aws_vpc.nat_vpc.id
  availability_zone = data.aws_availability_zones.available.names[0]

  tags = {
    Name      = "nat-instance-public-subnet"
    Terraform = true
  }
}

# Private subnet 1
resource "aws_subnet" "private" {
  cidr_block        = "10.0.11.0/24" #var.cidr_blocks[1]
  vpc_id            = aws_vpc.nat_vpc.id
  availability_zone = data.aws_availability_zones.available.names[0]

  tags = {
    Name      = "nat-instance-private-subnet"
    Terraform = true
  }
}

# create public route table 
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.nat_vpc.id

  tags = {
    Name      = "public-RT"
    Terraform = true
  }
  depends_on = [aws_subnet.public]
}

# create private route table 
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.nat_vpc.id

  tags = {
    Name      = "private-RT"
    Terraform = true
  }
  depends_on = [aws_subnet.private]
}

# always add route seperately
resource "aws_route" "public" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.nat_igw.id

  depends_on = [aws_route_table.public]
}

# Route table entry to forward traffic to NAT instance
resource "aws_route" "private_outbound_nat_route" {
  route_table_id         = aws_route_table.private.id
  destination_cidr_block = "0.0.0.0/0"
  network_interface_id   = aws_instance.nat_instance.primary_network_interface_id
}

resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "private" {
  subnet_id      = aws_subnet.private.id
  route_table_id = aws_route_table.private.id
}
