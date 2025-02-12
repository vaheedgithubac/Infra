# Security group for NAT Instance
module "sg" {
    source = "git::https://github.com/vaheedgithubac/Infra.git//modules/security_group"
    project_name = var.project_name
    env = var.env
    vpc_id = var.vpc_id
    sg_name = "nat_instance_sg"
    sg_description = "NAT Instance Security Group"
    common_tags = var.common_tags
}

# Security group for Private Subnet Instances
module "sg" {
    source = "git::https://github.com/vaheedgithubac/Infra.git//modules/security_group"
    project_name = var.project_name
    env = var.env
    vpc_id = var.vpc_id
    sg_name = "private_instance_sg"
    sg_description = "Private Instance Security Group"
    common_tags = var.common_tags
}

# NAT Instance Security group rule to allow SSH from remote ip
resource "aws_security_group_rule" "remote_admin" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = [var.remote_ip_to_connect_nat_instance]   #[var.remoteip]
  security_group_id = module.sg.sg_id     # aws_security_group.sg_nat_instance.id
}

# NAT Instance security group rule to allow all traffic from within the VPC
resource "aws_security_group_rule" "vpc-inbound" {
  type              = "ingress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = [var.vpc_cidr]
  security_group_id = module.sg.sg_id    # aws_security_group.sg_nat_instance.id
}

# NAT Instance security group rule to allow outbound traffic
resource "aws_security_group_rule" "outbound-nat-instance" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = module.sg.sg_id    # aws_security_group.sg_nat_instance.id
}

# Private instance security group rule to allow all traffic from public subnets 
resource "aws_security_group_rule" "private-subnet1-inbound" {
  type              = "ingress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = [var.public_subnets]   # [var.cidr_blocks[3]]
  security_group_id = module.sg.sg_id    # aws_security_group.sg_test_instance.id
}

# Private instance security group rule to allow outbound access
resource "aws_security_group_rule" "outbound-test-instance" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = module.sg.sg_id   # aws_security_group.sg_test_instance.id
}
