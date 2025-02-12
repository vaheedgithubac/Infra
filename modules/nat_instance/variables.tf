variable "resource_name" {}
variable "vpc_id" {}
variable "private_rout" {}
variable "private_subnet_cidr" {}

variable "common_tags" {
    type = map
}
############### Common variables for all Modules ############################
variable "project_name" {}
variable "env" {}
############### SG-MODULE related variables   ################################
# variable "project_name" {}
# variable "env" {}
# variable "common_tags" { type = map }
variable "vpc_id" {}
variable "remote_ip_to_connect_nat_instance" {}
variable "vpc_cidr" {}
variable "public_subnets" { type = list }

#############  EC2-MODULE related variables   #################################
# variable "project_name" {}
# variable "env" {}
variable "ami_id" {}
variable "public_key_name" {}
variable "public_subnet_ID_to_launch_nat_instance" {}

