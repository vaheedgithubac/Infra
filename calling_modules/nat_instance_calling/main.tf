module "nat_instance" {
  source = "git::https://github.com/vaheedgithubac/Infra//modules/nat_instance"

  vpc_id                                  = module.vpc.vpc_id
  vpc_cidr                                = var.vpc_cidr
  ami_id                                  = "ami-0ddfba243cbee3768"   #"ami-0c50b6f7dc3701ddd"
  public_key_name                         = "mumbai-1"
  public_subnet_ID_to_launch_nat_instance = module.vpc.public_subnet_ids[0]
  public_subnet_cidr                      = var.public_subnet_cidr
  private_subnet_ids                      = module.vpc.private_subnet_ids
  remote_ip_to_connect_nat_instance       = "<< your-ip-address >>/32"

  is_nat_instance = true

  project_name = var.project_name
  env          = var.env
  common_tags  = var.common_tags
}
