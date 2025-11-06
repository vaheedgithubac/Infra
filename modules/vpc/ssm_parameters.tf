# Storing parameters in AWS SSM PARAMETER STORE 
resource "aws_ssm_parameter" "availability_zones" {
  type  = "StringList"
  name  = "/${var.project_name}/${var.env}/availability_zones"
  value = join(",", local.azs)
  overwrite = true
}

resource "aws_ssm_parameter" "vpc_cidr" {
  type  = "String"
  name  = "/${var.project_name}/${var.env}/vpc_cidr"
  value = var.vpc_cidr
  #value = aws_vpc.vpc.cidr_block
  overwrite = true
}

resource "aws_ssm_parameter" "vpc_id" {
  type  = "String"
  name  = "/${var.project_name}/${var.env}/vpc_id"
  value = aws_vpc.vpc.id
  overwrite = true
}

resource "aws_ssm_parameter" "public_subnet_cidr" {
  type  = "StringList"
  name  = "/${var.project_name}/${var.env}/public_subnet_cidr"
  value = join(",", var.public_subnet_cidr)
  overwrite = true
}

resource "aws_ssm_parameter" "public_subnet_ids" {
  type  = "StringList"
  name  = "/${var.project_name}/${var.env}/public_subnet_ids"
  value = join(",", aws_subnet.public[*].id)
  overwrite = true
}

resource "aws_ssm_parameter" "private_subnet_cidr" {
  type  = "StringList"
  name  = "/${var.project_name}/${var.env}/private_subnet_cidr"
  value = join(",", var.private_subnet_cidr)
  overwrite = true
}

resource "aws_ssm_parameter" "private_subnet_ids" {
  type  = "StringList"
  name  = "/${var.project_name}/${var.env}/private_subnet_ids"
  value = join(",", aws_subnet.private.*.id)
  overwrite = true
}

resource "aws_ssm_parameter" "database_subnet_cidr" {
  type  = "StringList"
  name  = "/${var.project_name}/${var.env}/database_subnet_cidr"
  value       = join(",", var.database_subnet_cidr)
  overwrite = true
}

resource "aws_ssm_parameter" "database_subnet_ids" {
  type  = "StringList"
  name  = "/${var.project_name}/${var.env}/database_subnet_ids"
  value = join(",", aws_subnet.database.*.id)
  overwrite = true
}

resource "aws_ssm_parameter" "public_route_table_id" {
  type  = "String"
  name  = "/${var.project_name}/${var.env}/public_route_table_id"
  value = aws_route_table.public.id
  overwrite = true
}

resource "aws_ssm_parameter" "private_route_table_id" {
  type  = "String"
  name  = "/${var.project_name}/${var.env}/private_route_table_id"
  value = aws_route_table.private.id
  overwrite = true
}

resource "aws_ssm_parameter" "database_route_table_id" {
  type  = "String"
  name  = "/${var.project_name}/${var.env}/database_route_table_id"
  value = aws_route_table.database.id
  overwrite = true
}

