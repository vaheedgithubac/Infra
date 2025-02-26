data "aws_ssm_parameter" "backend_sg_id" {
  name = "/${var.project_name}/${var.env}/backend_sg_id"
}

data "aws_ssm_parameter" "private_subnet_ids" {
  name = "/${var.project_name}/${var.env}/private_subnet_ids"
  # depends_on = [ module.vpc ]
}

data "aws_ssm_parameter" "private_key" {
  name            = "/backend/ssh/private-key"
  with_decryption = true
  depends_on      = [aws_ssm_parameter.private_key]
}
