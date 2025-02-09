resource "aws_instance" "nat_instance" {
  ami                         = data.aws_ami.amzn_linux_2023_ami.id # Free-tier
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.public.id
  vpc_security_group_ids      = [aws_security_group.sg_nat_instance.id]
  associate_public_ip_address = true
  source_dest_check           = false
  user_data                   = <<-EOL
                                        #! /bin/bash
                                        sudo yum install iptables-services -y
                                        sudo systemctl enable iptables
                                        sudo systemctl start iptables
                                        sudo sysctl -w net.ipv4.ip_forward=1
                                        sudo /sbin/iptables -t nat -A POSTROUTING -o enX0 -j MASQUERADE
                                        # sudo /sbin/iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
                                        sudo /sbin/iptables -F FORWARD
    EOL

  user_data_replace_on_change = true
  key_name                    = "mumbai-1"

  root_block_device {
    volume_size = "8"
    volume_type = "gp2"
    encrypted   = true
  }

  tags = {

    Name      = "NAT EC2 Instance"
    Terraform = true
  }
}
########################################### Test Instance ##########################################################
# Build the test instance
resource "aws_instance" "test_instance" {
  ami                    = data.aws_ami.amzn_linux_2023_ami.id # Free-tier
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.private.id
  vpc_security_group_ids = [aws_security_group.sg_test_instance.id]
  key_name               = "mumbai-1"


  # Root disk for test instance
  root_block_device {
    volume_size = "8"
    volume_type = "gp2"
    encrypted   = true
  }

  tags = {
    Name = "test-instance"
  }
}

