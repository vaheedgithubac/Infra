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
variable "database_subnet_ids" { type = list }  # For subnet group creation
variable "db_subnet_group_name" {}

variable "engine" {}
variable "engine_version" {}
variable "identifier" {}
variable "username" {}
variable "password" {}
variable "availability_zone" {}
variable "instance_class" {}         # "db.t3.micro" 
variable "multi_az" {}               # false
variable "db_name" {}                # null
variable "skip_final_snapshot" {}    # true
variable "deletion_protection" {}    # false
variable "allocated_storage" { type = number }  # 8 (means 8GB)
variable "vpc_security_group_ids" { type = list }
# variable "port" {}                   # 3306
#############################################################################################################

