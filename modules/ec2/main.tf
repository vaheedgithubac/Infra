resource "aws_instance" "ec2_instance" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  key_name                    = var.public_key_name
  vpc_security_group_ids      = [var.sg_id]
  subnet_id                   = var.subnet_id
  associate_public_ip_address = var.associate_public_ip
  iam_instance_profile        = var.instance_profile
  user_data                   = file("${path.module}/user-data.sh")
  
  root_block_device {
    delete_on_termination = true
    encrypted             = false
    volume_size           = var.root_volume_size
    volume_type           = "gp2"
    tags = {
      Name          = locals.root_volume_final_name 
      project_name  = var.project_name
      environment   = var.env
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
          Name = local.ec2_final_name 
      }
    )
}
