
module "vpc" {
  source = "git::https://github.com/vaheedgithubac/Infra//modules/vpc" # Give the path to VPC MODULE accordingly


  #region      = var.region

  project_name = var.project_name
  env          = var.env
  vpc_cidr     = var.vpc_cidr
  common_tags  = var.common_tags

  # All the counts should be same 
  azs_count             = 2
  public_subnet_count   = 2
  private_subnet_count  = 2
  database_subnet_count = 2

  public_subnet_cidr   = var.public_subnet_cidr
  private_subnet_cidr  = var.private_subnet_cidr
  database_subnet_cidr = var.database_subnet_cidr

}
