resource "aws_instance" "ec2_instance" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  key_name                    = var.public_key_name
  vpc_security_group_ids      = var.sg_id      # for multiple values        # [var.sg_id] --> for single value
  subnet_id                   = var.subnet_id
  associate_public_ip_address = var.associate_public_ip_address
  iam_instance_profile        = var.iam_instance_profile
  user_data                   = var.is_nat_instance ? file("${path.module}/nat_user_data.sh") : var.user_data
  # user_data                   = var.user_data

  # If 'source_dest_check = false' --> NAT Instance. # If 'source_dest_check = true' --> Normal Instance
  source_dest_check           = var.is_nat_instance ? false : true

  root_block_device {
    delete_on_termination = true
    encrypted             = false
    volume_size           = var.root_volume_size
    volume_type           = "gp2"

    tags = {
      Name          = local.root_volume_final_name 
      Project_Name  = var.project_name
      Environment   = var.env
    }
  }

  timeouts {
      create = "10m"
      update = "10m"
      delete = "10m"
  }
  
  tags = merge(
      var.common_tags,
      var.ec2_tags,
      {
          Name = local.resource_final_name 
      }
    )
}

# Create and attach EIP (Elastic IP) for NAT INSTANCE
#resource "aws_eip" "nat_instance_eip" {
#  count = var.is_nat_instance ? 1 : 0

#  domain   = "vpc"
#  instance = aws_instance.ec2_instance.id
  # network_interface = aws_instance.ec2_instance.primary_network_interface_id
#}





