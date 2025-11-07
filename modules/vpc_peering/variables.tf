variable "region" {}

variable "requester_vpc_id" {}
variable "accepter_vpc_id" {}

variable "requester_vpc_cidr" {}
variable "accepter_vpc_cidr" {}

variable "requester_route_table_ids" { type = list }
variable "accepter_route_table_ids" { type = list }
