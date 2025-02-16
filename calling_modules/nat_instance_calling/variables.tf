variable "project_name" {}
variable "env" { default = "dev" }

variable "common_tags" {
  default = {
    Project     = "expense"
    Environment = "dev"
    Terraform   = "true"
  }
}
