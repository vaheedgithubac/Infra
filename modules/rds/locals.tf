locals {
  resource_final_name = "${var.project_name}-${var.env}-${var.sg_name}"    # expense-dev-<sg_name>
  # private_subnet_ids  = split(",", data.aws_ssm_parameter.private_subnet_ids.value)
  identifier = "${var.project_name}-${var.env}-db-instance"  # Mysql Instance Name
}
