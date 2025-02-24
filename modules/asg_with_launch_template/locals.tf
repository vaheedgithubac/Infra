locals {
  launch_template_name     = "${var.lt_type}-${var.project_name}-${var.env}-launch-template"
  auto_scaling_group_name  = "${var.asg_type}-${var.project_name}-${var.env}-autoscaling-group"
  auto_scaling_policy_name = "${var.asg_type}-${var.project_name}-${var.env}-autoscaling-policy"
}
