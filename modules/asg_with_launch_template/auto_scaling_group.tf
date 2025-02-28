# Create Auto Scaling Group-ASG
resource "aws_autoscaling_group" "autoscaling_group" {
  name                      = local.auto_scaling_group_name
  min_size                  = var.min_size
  max_size                  = var.max_size
  desired_capacity          = var.desired_capacity               # starting of the auto scaling group
  health_check_grace_period = var.health_check_grace_period
  health_check_type         = var.health_check_type
  target_group_arns         = var.target_group_arns              # [var.target_group_arns] # attaches target group to ASG
  # force_delete              = true

  launch_template {
    id      = aws_launch_template.launch_template.id
    version = "$Latest"
  }
  
  vpc_zone_identifier       = var.vpc_zone_identifier        # [var.vpc_zone_identifier]  # list of public / private  subnet_ids to launch ASG

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
    # ignore_changes        = [ desired_capacity, target_group_arns]   ignore to relaunch instances in asg if desired_capacity or target_group_arns changes
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
