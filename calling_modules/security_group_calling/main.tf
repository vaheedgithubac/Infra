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
