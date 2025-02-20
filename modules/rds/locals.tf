locals {
  resource_final_name = "${var.project_name}-${var.env}-${var.sg_name}"    # expense-dev-<sg_name>
  identifier = "${var.project_name}-${var.env}-db-instance"  # Mysql Instance Name
}
