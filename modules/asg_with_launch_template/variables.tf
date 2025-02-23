#################### Common - Variables  ####################################################################
### Tags
variable "project_name" {}
variable "env" {}
variable "common_tags" { type = map(any) }
#################### Launch Template - Variables  ###########################################################
variable "image_id" {}
variable "instance_type" {}
variable "key_name" {}
variable "vpc_security_group_ids" { type = list }
variable "user_data" { default = null }
variable "iam_instance_profile" { default = null }
variable "associate_public_ip_address" { default = false }
variable "lt_type" {}

variable "lt_tags" {
  type    = map(any)
  default = {}
}
#################### ASG - Variables  ######################################################################
variable "asg_type" {}                              # frontend / backend
variable "target_group_arns" { type = list }        # For attaching ec2 instances to ASG
variable "vpc_zone_identifier" { type = list(any) } # private / public  subnet_ids to launch ASG
############################################################################################################

