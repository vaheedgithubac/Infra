module "ec2" {
  source = "git::https://github.com/vaheedgithubac/Infra.git//modules/ec2"

  ami_id                      = var.ami_id
  public_key_name             = var.public_key_name
  sg_id                       = module.sg.sg_id
  subnet_id                   = var.public_subnet_ID_to_launch_nat_instance  #"subnet-088e8443a70102e2a" #1a
  project_name                = var.project_name
  env                         = var.env
  associate_public_ip_address = true
  user_data                   = file("${path.module}/nat_user_data.sh")
  common_tags                 = var.common_tags
}
