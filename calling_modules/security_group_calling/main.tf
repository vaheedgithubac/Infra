module "mysql_sg" {
    source = "../terraform-aws-securitygroup"
    project_name = var.project_name
    environment = var.environment
    sg_name = "mysql"
    sg_description = "Created for MySQL instances in expense dev"
    vpc_id = data.aws_ssm_parameter.vpc_id.value
    common_tags = var.common_tags
}

resource "aws_security_group_rule" "allow_http" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]         #[var.remoteip]
  security_group_id = module.mysql_sg.sg_id   #aws_security_group.sg_nat_instance.id
}
