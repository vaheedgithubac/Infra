locals {
  auto_scaling_group_name  = "${var.asg_type}-${var.project_name}-${var.env}-autoscaling-group"
  auto_scaling_policy_name = "${var.asg_type}-${var.project_name}-${var.env}-autoscaling-policy"
}
