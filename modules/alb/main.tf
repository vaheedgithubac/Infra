# Create ALB
resource "aws_lb" "application_load_balancer" {
  name                       = "${local.resource_name}-alb"
  internal                   = var.internal
  load_balancer_type         = "application"
  security_groups            = local.alb_sg_id    # [var.alb_security_group_id]
  subnets                    = var.subnets
  enable_deletion_protection = false

  #depends_on         = [aws_internet_gateway.igw_vpc]

  tags = merge(
    var.alb_tags,
    var.common_tags,
    {
      Name = "${alb_type}-${var.project_name}-${var.env}-alb"
    }
  )
}
