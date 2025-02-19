variable "internal" {}
variable "alb_security_group_id" {}
variable "subnets" {}
variable "vpc_id" {}

variable "project_name" {}
variable "env" {}
variable "common_tags" {
  type    = map()
  default = {}
}
variable "alb_tags" {
  type    = map()
  default = {}
}
