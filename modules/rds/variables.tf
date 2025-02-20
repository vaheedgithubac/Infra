#############################   Common Variables   #########################################
variable "project_name" { default = "expense" }
variable "env" { default = "dev" }

variable "common_tags" {
  default = {
    Project     = "expense"
    Environment = "dev"
    Terraform   = "true"
  }
}

###########################################       RDS variables    #########################################
variable "database_subnet_ids" {}  # For subnet group creation
variable "private_subnet_cidr" {}  # SG purpose
variable "db_subnet_group_name" {}

variable "engine" {}
variable "engine_version" {}
# variable "identifier" {}
variable "username" {}
variable "password" {}
variable "availability_zone" {}
# variable "db_subnet_group_name" {}
# variable "vpc_security_group_ids" {}

### Default values for RDS
variable "multi_az" { default = false}
variable "db_name" { default = ""}
variable "skip_final_snapshot" { default = true }
variable "instance_class" { default = "db.t3.micro" }
variable "allocated_storage" { 
    type = number
    default = 8
}

############################################# SG variables ############################################
variable "sg_name" {}
variable "sg_description" {}
variable "vpc_id" {}
