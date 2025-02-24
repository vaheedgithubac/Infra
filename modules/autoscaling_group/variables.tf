#################### Common - Variables  ###################################################################
### Tags
variable "project_name" {}
variable "env" {}
variable "common_tags" { type = map(any) }
#################### ASG - Variables  ######################################################################
variable "asg_type" {}                              # frontend / backend
variable "target_group_arns" { type = list }        # For attaching ec2 instances to ASG
variable "vpc_zone_identifier" { type = list(any) } # private / public  subnet_ids to launch ASG
############################################################################################################
