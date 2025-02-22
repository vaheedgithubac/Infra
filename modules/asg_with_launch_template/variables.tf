variable "image_id" {}
variable "sg_id" {}
variable "key_name" {}
variable "instance_type" {}
variable "asg_type" {}                              # frontend / backend
variable "target_group_arns" { type = list }                     # For attaching ec2 instances
variable "vpc_zone_identifier" { type = list(any) } # private / public  subnet_ids to launch ASG
variable "associate_public_ip_address" { type = bool }

variable "user_data" { default = null }
variable "iam_instance_profile" { default = null }
variable "lt_tags" {
  type    = map(any)
  default = {}
}

variable "project_name" {}
variable "env" {}
variable "common_tags" { type = map(any) }
