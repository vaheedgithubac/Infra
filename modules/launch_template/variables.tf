#################### Common - Variables  ####################################################################
### Tags
variable "project_name" {}
variable "env" {}
variable "common_tags" { type = map(any) }
#################### Launch Template - Variables  ###########################################################
variable "lt_type" {}
variable "image_id" {}
variable "instance_type" {}
variable "key_name" {}
variable "vpc_security_group_ids" { type = list }
variable "user_data" { default = null }
variable "iam_instance_profile" { default = null }
variable "associate_public_ip_address" { default = false }

variable "lt_tags" {
  type    = map(any)
  default = {}
}
#############################################################################################################
