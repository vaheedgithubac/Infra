# Create Launch Template
resource "aws_launch_template" "launch_template" {

  name                                 = local.launch_template_name
  image_id                             = var.image_id   #aws_ami_from_instance.backend.id
  instance_type                        = var.instance_type
  key_name                             = var.key_name    # The public key name to use for the instance
  instance_initiated_shutdown_behavior = "terminate"

  update_default_version = true
  vpc_security_group_ids = var.vpc_security_group_ids 

  user_data = var.user_data != null ? filebase64(var.user_data) : var.user_data         # filebase64("${path.module}/${var.user_data}")   

  iam_instance_profile { name = var.iam_instance_profile }
  network_interfaces { associate_public_ip_address = var.associate_public_ip_address }

#   monitoring { enabled = true }

  tag_specifications {
    resource_type = "instance"

    tags = merge(
      var.lt_tags,
      var.common_tags,
      {
          Name = local.resource_name
      }
    )
  }
}
