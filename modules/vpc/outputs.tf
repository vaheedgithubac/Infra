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

# This returns entire internet_gateway object, if you want only id then use "aws_internet_gateway.internet_gateway.id"
output "internet_gateway" {
  value = aws_internet_gateway.internet_gateway
}

output "public_route_table_id" {
  value = aws_route_table.public.id  
}

output "private_route_table_id" {
  value = aws_route_table.private.id  
}

output "database_route_table_id" {
  value = aws_route_table.database.id  
}
