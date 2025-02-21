##################################  Mandatory Variables  ####################################
variable "sg_name"{}
variable "sg_description" {}
variable "vpc_id" {}

### Tags
variable "project_name" {}
variable "env" {}
variable "common_tags" {
    type = map
}

###################################  Default Variables   ########################################
variable "sg_tags" {
    default = {}
}
