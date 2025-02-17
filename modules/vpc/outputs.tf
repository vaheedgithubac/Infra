output "project_name" {
  value = var.project_name
}

output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "public_subnet_ids" {
  value = aws_subnet.public[*].id  
}

output "private_subnet_ids" {
  value = aws_subnet.private.*.id
}

# This return entire internet_gateway object, if you want only id then use "aws_internet_gateway.internet_gateway.id"
output "internet_gateway" {
  value = aws_internet_gateway.internet_gateway
}
