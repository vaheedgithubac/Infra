##################################  Mandatory Variables  ####################################
variable "project_name" {}

variable "env" {}

variable "sg_name"{}

variable "sg_description" {}

variable "vpc_id" {}

variable "common_tags" {
    type = map
}

###################################  Default Variables   ########################################
variable "sg_tags" {
    default = {}
}
