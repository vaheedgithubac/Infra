################################################################
#                    Mandatory variables                       # 
################################################################
variable "ami_id" {}
variable "public_key_name" {}
variable "sg_id" {}
variable "subnet_id" {}
variable "project_name" {}
variable "env" {}
variable "common_tags" { type = map }

#####################################################################################################
#                Default setting variables, you can overwrite them while calling                    #
#####################################################################################################
variable "is_nat_instance" { default = false }
variable "associate_public_ip_address" { default = false }
variable "ec2_tags" { default = {} } 
variable "iam_instance_profile" { default = "" }
variable "user_data" { default = "" }

variable "root_volume_size" {
  type = number
  default = 8
}

variable "instance_type" {
    default = "t2.micro"
    validation {
      condition     = contains(["t2.micro", "t2.small", "t2.medium"], var.instance_type)
        error_message = "Valid values for instance type are: t2.micro t2.small t2.medium"
    } 
}






