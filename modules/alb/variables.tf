variable "internal" {}
variable "alb_sg_ids" {}
variable "subnets" {}
variable "vpc_id" {}

variable "project_name" {}
variable "env" {}
variable "common_tags" { type = map }

variable "alb_tags" {
  type    = map()
  default = {}
}
