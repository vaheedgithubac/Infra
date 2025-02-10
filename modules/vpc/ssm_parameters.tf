# Storing parameters in AWS SSM PARAMETER STORE 

resource "aws_ssm_parameter" "vpc_id" {
  type  = "String"
  name  = "/${var.project_name}/${var.env}/vpc_id"
  value = aws_vpc.vpc.id
}

resource "aws_ssm_parameter" "vpc_cidr" {
  type  = "String"
  name  = "/${var.project_name}/${var.env}/vpc_cidr"
  value = aws_vpc.vpc.cidr_block
}

resource "aws_ssm_parameter" "public_subnet_ids" {
  type  = "StringList"
  name  = "/${var.project_name}/${var.env}/public_subnet_ids"
  value = join(",", aws_subnet.public[*].id)
}

resource "aws_ssm_parameter" "private_subnet_ids" {
  type  = "StringList"
  name  = "/${var.project_name}/${var.env}/private_subnet_ids"
  value = join(",", aws_subnet.private.*.id)
}


