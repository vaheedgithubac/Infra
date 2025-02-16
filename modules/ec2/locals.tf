locals {
    resource_final_name = var.is_nat_instance ? "NAT-INSTANCE-${var.project_name}-${var.env}" : "${var.project_name}-${var.env}-ec2"                                   # expense-dev-ec2
    root_volume_final_name = "${var.project_name}-${var.env}-ec2-root-volume"                   # expense-dev-ec2-root-volume
}
