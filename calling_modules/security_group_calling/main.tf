module "mysql_sg" {
    # source = "git::https://github.com/daws-81s/terraform-aws-vpc.git?ref=main"
    source = #"../terraform-aws-security-group"   Give the path accordingly
    project_name = var.project_name
    environment = var.environment
    sg_name = "mysql"
    vpc_id = module.vpc.vpc_id
    common_tags = var.common_tags
    sg_tags = var.mysql_sg_tags
}

module "mysql_sg" {
    source = "../terraform-aws-securitygroup"
    project_name = var.project_name
    environment = var.environment
    sg_name = "mysql"
    sg_description = "Created for MySQL instances in expense dev"
    vpc_id = data.aws_ssm_parameter.vpc_id.value
    common_tags = var.common_tags
}
