# VPC-MODULE Calling
module "vpc" {
  source = "git::https://github.com/vaheedgithubac/Infra//modules/vpc" # Give the path to VPC MODULE accordingly

  # All the counts should be same 
  azs_count             = 2
  public_subnet_count   = 2
  private_subnet_count  = 2
  database_subnet_count = 2

  vpc_cidr             = "10.100.0.0/16"
  public_subnet_cidr   = ["10.100.1.0/24", "10.100.2.0/24"]
  private_subnet_cidr  = ["10.100.11.0/24", "10.100.12.0/24"]
  database_subnet_cidr = ["10.100.31.0/24", "10.100.32.0/24"]

  project_name = var.project_name
  env          = var.env
  common_tags  = var.common_tags
}

# NAT-INSTANCE Module Calling
module "nat_instance" {
  source     = "git::https://github.com/vaheedgithubac/Infra//modules/nat_instance"
  depends_on = [module.vpc]

  vpc_id                                  = data.aws_ssm_parameter.vpc_id.value
  vpc_cidr                                = data.aws_ssm_parameter.vpc_cidr.value
  ami_id                                  = "ami-0ddfba243cbee3768" #"ami-0c50b6f7dc3701ddd"
  public_key_name                         = "mumbai-1"
  public_subnet_ID_to_launch_nat_instance = local.public_subnet_ids[0] 
  public_subnet_cidr                      = local.public_subnet_cidr   # for private instance sg purpose
  private_subnet_cidr                     = local.private_subnet_cidr  # for databse instance sg purpose
  # private_subnet_ids                      = local.private_subnet_ids #module.vpc.private_subnet_ids 
  remote_ip_to_connect_nat_instance = "49.204.160.226/32"

  is_nat_instance = true

  project_name = var.project_name
  env          = var.env
  common_tags  = var.common_tags

}
