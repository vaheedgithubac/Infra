locals {
  requester_vpc_route_table_ids = data.aws_route_tables.requester.ids
  accepter_vpc_route_table_ids = data.aws_route_tables.accepter.ids

  requester_vpc_cidr  =  data.aws_vpc.requester.cidr_block  
  accepter_vpc_cidr   =  data.aws_vpc.accepter.cidr_block
}
