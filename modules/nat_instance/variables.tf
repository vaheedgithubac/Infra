################  NAT Instance variables  ####################################
variable "vpc_id" {}
variable "public_subnet_cidr" { type = list(any) }
variable "private_subnet_cidr" { type = list }
# variable "private_subnet_ids" { type = list }
  
############### Common variables for all Modules ############################
variable "project_name" {}
variable "env" {}
variable "common_tags" {
    type = map
}
############### SG-MODULE related variables   ################################
# variable "project_name" {}
# variable "env" {}
# variable "common_tags" { type = map }
# variable "vpc_id" {}  
# already declared above variables for other purpose

variable "remote_ip_to_connect_nat_instance" {}
variable "vpc_cidr" {}

#############  EC2-MODULE related variables   #################################
# variable "project_name" {}
# variable "env" {}
# variable "common_tags" { type = map }
variable "ami_id" {}
variable "public_key_name" {}
variable "public_subnet_ID_to_launch_nat_instance" {}

variable "is_nat_instance" { default = false }

  
