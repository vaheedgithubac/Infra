locals {
  resource_name = "${var.project_name}-${var.env}"    # expense-dev-<sg_name>
  identifier = "${var.project_name}-${var.env}-db-instance"  # Mysql Instance Name
}
