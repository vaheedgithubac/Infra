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
  for_each = toset(data.aws_route_tables.requester.ids)

  route_table_id         = each.value                                  
  destination_cidr_block = data.aws_vpc.accepter.cidr_block     
  vpc_peering_connection_id = aws_vpc_peering_connection.peering.id
}

# updating destination vpc_cidr route in all the route tables of "accepter vpc"
resource "aws_route" "accepter" {
  for_each = toset(data.aws_route_tables.accepter.ids)

  route_table_id         = each.value                                    
  destination_cidr_block = data.aws_vpc.requester.cidr_block      
  vpc_peering_connection_id = aws_vpc_peering_connection.peering.id

}
