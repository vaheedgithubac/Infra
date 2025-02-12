# create vpc
resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cidr
  instance_tenancy     = "default"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = merge(
    var.common_tags,
    {
      Name = "${local.resource_name}-vpc-${var.vpc_count}"
    }
  )
}

# create internet gateway and attach it to vpc
resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.vpc.id

  tags = merge(
    var.common_tags,
    {
      Name = "${local.resource_name}-igw"
    }
  )
  depends_on = [aws_vpc.vpc]
}

# use data source to get all avalablility zones in region
# data "aws_availability_zones" "available_zones" {}

# create public subnet
resource "aws_subnet" "public" {
  count = length(var.public_subnet_cidr)
  
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.public_subnet_cidr[count.index]
  availability_zone       = local.azs[count.index]
  map_public_ip_on_launch = true
  
  tags = merge(
    var.common_tags,
    {
      Name = "${local.resource_name}-public-subnet-${local.azs[count.index]}"
    }
  )
  depends_on = [aws_vpc.vpc]
}

# create private subnet
resource "aws_subnet" "private" {
  count = length(var.private_subnet_cidr)
  
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.private_subnet_cidr[count.index]
  availability_zone       = local.azs[count.index]
  map_public_ip_on_launch = false

  tags = merge(
    var.common_tags,
    {
      Name = "${local.resource_name}-private-subnet-${local.azs[count.index]}"
    }
  )
}

# create database subnet
resource "aws_subnet" "database" {
  count = length(var.database_subnet_cidr)
  
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.database_subnet_cidr[count.index]
  availability_zone       = local.azs[count.index]
  map_public_ip_on_launch = false

  tags = merge(
    var.common_tags,
    {
      Name = "${local.resource_name}-database-subnet-${local.azs[count.index]}"
    }
  )
}

# create public route table 
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.vpc.id

  tags = merge(
    var.common_tags,
    {
      Name = "${local.resource_name}-public-RT"
    }
  )
  depends_on = [aws_subnet.public]
}

# always add route seperately
resource "aws_route" "public" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.internet_gateway.id

   depends_on = [aws_route_table.public]
}

# associate public route table to public subnet
resource "aws_route_table_association" "public" {
  count = length(var.public_subnet_cidr)
  
  subnet_id      = aws_subnet.public[count.index].id                      
  route_table_id = aws_route_table.public.id
  
   lifecycle {
    create_before_destroy = true  # Ensures new association is created before destroying the old one
  }
}


