variable "region" {}

variable "requester_vpc_id" {}
variable "accepter_vpc_id" {}

variable "requester_vpc_cidr" {}
variable "accepter_vpc_cidr" {}

variable "route_table_ids" { type = list }
