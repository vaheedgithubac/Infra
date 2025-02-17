# VPC-MODULE Calling
module "vpc" {
  source = "git::https://github.com/vaheedgithubac/Infra//modules/vpc"  # Give the path to VPC MODULE accordingly

  project_name = var.project_name
  env          = var.env
  common_tags  = var.common_tags

  # All the counts should be same 
  azs_count             = 2
  public_subnet_count   = 2
  private_subnet_count  = 2
  database_subnet_count = 2

  vpc_cidr     = "10.100.0.0/16"
  public_subnet_cidr   = ["10.100.1.0/24", "10.100.2.0/24"]
  private_subnet_cidr  = ["10.100.11.0/24", "10.100.12.0/24"]
  database_subnet_cidr = ["10.100.31.0/24", "10.100.32.0/24"]
}
