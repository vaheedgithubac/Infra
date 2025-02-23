# Create Auto Scaling Group-ASG
resource "aws_autoscaling_group" "autoscaling_group" {
  name                      = local.auto_scaling_group_name
  min_size                  = 2
  max_size                  = 5
  desired_capacity          = 2 # starting of the auto scaling group
  health_check_grace_period = 60
  health_check_type         = "ELB"
  target_group_arns         = var.target_group_arns              # [var.target_group_arns] # attaches target group to ASG
  # force_delete              = true

  launch_template {
    id      = aws_launch_template.launch_template.id
    version = "$Latest"
  }
  
  vpc_zone_identifier       = var.vpc_zone_identifier        # [var.vpc_zone_identifier]  # list of private / public  subnet_ids to launch ASG

#Automatically refresh all instances after the group is updated
  
  instance_refresh {
    strategy = "Rolling"
    preferences {
      min_healthy_percentage = 50
    }
    triggers = ["launch_template"]
  }

  tag {
    key                 = "Name"
    value               = local.auto_scaling_group_name
    propagate_at_launch = true
  }

  # If instances are not healthy within 15min, autoscaling will delete that instance
  timeouts {
    delete = "15m"
  }

  tag {
    key                 = "Project"
    value               = "Expense"
    propagate_at_launch = false
  }

  lifecycle {
    create_before_destroy = true
    # ignore_changes        = [target_group_arns]
  }

}

# Create Auto Scaling Policy
resource "aws_autoscaling_policy" "autoscaling_policy" {
  name                    = local.auto_scaling_policy_name
  policy_type             = "TargetTrackingScaling"
  autoscaling_group_name  =  aws_autoscaling_group.autoscaling_group.name  #aws_autoscaling_group.backend.name
  
  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }

    target_value = 70.0
  }
  
}
