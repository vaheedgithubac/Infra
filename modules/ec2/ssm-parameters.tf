resource "aws_ssm_parameter" "nat_primary_network_interface_id" {
  count = var.is_nat_instance ? 1 : 0
  name  = "/${var.project_name}/${var.environment}/nat_primary_network_interface_id"
  type  = "String"
  value = aws_instance.ec2_instance.primary_network_interface_id
}
