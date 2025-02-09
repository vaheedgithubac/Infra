# Security Group for NAT Instance
resource "aws_security_group" "sg_nat_instance" {
  name        = "sg_nat_instance"
  description = "Security Group for NAT instance"
  vpc_id      = aws_vpc.nat_vpc.id

  tags = {
    Name      = "sg_nat_instance"
    Terraform = true
  }
}

# Security Group for test instance
resource "aws_security_group" "sg_test_instance" {
  name        = "sg_test_instance"
  description = "Security Group for test instance"
  vpc_id      = aws_vpc.nat_vpc.id

  tags = {
    Name      = "sg_test_instance"
    Terraform = true
  }
}

# NAT Instance Security group rule to allow SSH from remote ip
resource "aws_security_group_rule" "remote_admin" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["152.59.196.177/32"] #[var.remoteip]
  security_group_id = aws_security_group.sg_nat_instance.id
}

# NAT Instance security group rule to allow all traffic from within the VPC
resource "aws_security_group_rule" "vpc-inbound" {
  type              = "ingress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["10.0.0.0/16"]
  security_group_id = aws_security_group.sg_nat_instance.id
}

# NAT Instance security group rule to allow outbound traffic
resource "aws_security_group_rule" "outbound-nat-instance" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.sg_nat_instance.id
}

# Test (private) instance security group rule to allow all traffic from public subnet 
resource "aws_security_group_rule" "private-subnet1-inbound" {
  type              = "ingress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["10.0.0.0/24"] #[var.cidr_blocks[3]]
  security_group_id = aws_security_group.sg_test_instance.id
}

# Test (private) instance security group rule to allow outbound access
resource "aws_security_group_rule" "outbound-test-instance" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.sg_test_instance.id
}
