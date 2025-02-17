data "aws_ssm_parameter" "private_route_table_id" {
  name = "/${var.project_name}/${var.environment}/private_route_table_id"
}
