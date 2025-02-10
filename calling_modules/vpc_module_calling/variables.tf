variable "project_name" {}
variable "vpc_cidr" {}
variable "env" { default = "dev" }

variable "common_tags" {
  default = {
    Project     = "expense"
    Environment = "dev"
    Terraform   = "true"
  }
}

variable "public_subnet_cidr" {}
variable "private_subnet_cidr" {}
variable "database_subnet_cidr" {}
