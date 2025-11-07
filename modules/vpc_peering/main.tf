resource "aws_vpc_peering_connection" "peering" {

  vpc_id      = var.requester_vpc_id      # requester VPC
  peer_vpc_id = var.accepter_vpc_id       # accepter VPC
  auto_accept = true

  tags = {
    Name = "vpc-peering-connection"
    Side = "Requester"
  }
}

# updating destination vpc_cidr route in all the route tables of "requester vpc"
resource "aws_route" "requester" {
  count = length(data.aws_route_tables.requester.ids)

  route_table_id         = tolist(data.aws_route_tables.requester.ids)[count.index]
  # since we set count parameter, it is treated as list, even single element you should write list syntax
  destination_cidr_block = var.peering_dest_cidr_accepter
  vpc_peering_connection_id = aws_vpc_peering_connection.peering.id
}

# updating destination vpc_cidr route in all the route tables of "accepter vpc"
resource "aws_route" "accepter" {
  count = length(data.aws_route_tables.accepter.ids)

  route_table_id         = tolist(data.aws_route_tables.accepter.ids)[count.index]
  # since we set count parameter, it is treated as list, even single element you should write list syntax
  destination_cidr_block = var.peering_dest_cidr_requester
  vpc_peering_connection_id = aws_vpc_peering_connection.peering.id

}
