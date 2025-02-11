module "sg" {
  source = "git::https://github.com/vaheedgithubac/Infra.git//modules/security_group"
  project_name   = var.project_name
  env            = var.env
  sg_name        = var.sg_name
  sg_description = var.sg_description
  vpc_id         = var.vpc_id
  common_tags    = var.common_tags
}

resource "aws_security_group_rule" "allow_http" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]   #[var.remoteip]
  security_group_id = module.sg.sg_id #aws_security_group.sg_nat_instance.id
}

# APP ALB accepting traffic from bastion
# resource "aws_security_group_rule" "app_alb_bastion" {
#  type              = "ingress"
#  from_port         = 80
#  to_port           = 80
#  protocol          = "tcp"
#  source_security_group_id       = module.bastion_sg.sg_id
#  security_group_id = module.app_alb_sg.sg_id
# }
