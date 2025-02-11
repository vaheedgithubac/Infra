resource "aws_instance" "ec2_instance" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  key_name                    = var.public_key_name
  vpc_security_group_ids      = [var.sg_id]
  subnet_id                   = var.subnet_id
  associate_public_ip_address = var.associate_public_ip_address
  iam_instance_profile        = var.iam_instance_profile
  user_data                   = var.nat_instance ? file("${path.module}/user-data.sh") : var.user_data
  
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
