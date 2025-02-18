# Create a security group for MYSQL
module "mysql_sg" {
  source = "git::https://github.com/vaheedgithubac/Infra.git//modules/security_group"

  vpc_id = var.vpc_id
  sg_name = var.sg_name
  sg_description = var.sg_description

  project_name = var.project_name
  env = var.env
  common_tags = var.common_tags
}

# MYSQL Security group rule to allow SSH from remote ip
resource "aws_security_group_rule" "remote_admin" {
  type              = "ingress"
  from_port         = 3306
  to_port           = 3306
  protocol          = "tcp"
  cidr_blocks       = [var.private_subnet_cidr]     
  security_group_id = module.mysql_sg.sg_id     # aws_security_group.sg_nat_instance.id
}
