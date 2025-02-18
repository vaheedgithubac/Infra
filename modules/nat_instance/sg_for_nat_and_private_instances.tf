# Security group for NAT Instance
module "nat_sg" {
    source = "git::https://github.com/vaheedgithubac/Infra.git//modules/security_group"
    project_name = var.project_name
    env = var.env
    vpc_id = var.vpc_id
    sg_name = "nat_instance_sg"
    sg_description = "NAT Instance Security Group"
    common_tags = var.common_tags
}

# Security group for Private Subnet Instances
module "private_sg" {
    source = "git::https://github.com/vaheedgithubac/Infra.git//modules/security_group"
    project_name = var.project_name
    env = var.env
    vpc_id = var.vpc_id
    sg_name = "private_instance_sg"
    sg_description = "Private Instance Security Group"
    common_tags = var.common_tags
}

# Security group for Private Subnet Instances
module "database_sg" {
    source = "git::https://github.com/vaheedgithubac/Infra.git//modules/security_group"
    project_name = var.project_name
    env = var.env
    vpc_id = var.vpc_id
    sg_name = "database_instance_sg"
    sg_description = "Database Instance Security Group"
    common_tags = var.common_tags
}

# NAT Instance Security group rule to allow SSH from remote ip
resource "aws_security_group_rule" "remote_admin" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = [var.remote_ip_to_connect_nat_instance]   #[var.remoteip]
  security_group_id = module.nat_sg.sg_id     # aws_security_group.sg_nat_instance.id
}

# NAT Instance security group rule to allow all traffic from within the VPC
resource "aws_security_group_rule" "vpc-inbound" {
  type              = "ingress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = [var.vpc_cidr]
  security_group_id = module.nat_sg.sg_id    # aws_security_group.sg_nat_instance.id
}

# Private instances security group rule to allow all traffic from public subnets ( Public Subnets ---> Private Subnets ) 
resource "aws_security_group_rule" "private-subnet1-inbound" {
  type              = "ingress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = var.public_subnet_cidr   # [var.cidr_blocks[3]]
  security_group_id = module.private_sg.sg_id    # aws_security_group.sg_test_instance.id
}

# Database Instances security group rule to allow traffic from Private Subnets ( Private Subnets ---> Database Subnets )
resource "aws_security_group_rule" "vpc-inbound" {
  type              = "ingress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = var.private_subnet_cidr
  security_group_id = module.database_sg.sg_id    # aws_security_group.sg_nat_instance.id
}

