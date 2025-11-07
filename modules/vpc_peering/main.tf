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
  #count = length(tolist(local.requester_vpc_route_table_ids))
  for_each = toset(var.requester_vpc_route_table_ids)

  route_table_id         = each.value                            # local.requester_vpc_route_table_ids[count.index]                                  
  destination_cidr_block = var.accepter_vpc_cidr                 # data.aws_vpc.accepter.cidr_block     
  vpc_peering_connection_id = aws_vpc_peering_connection.peering.id
}

# updating destination vpc_cidr route in all the route tables of "accepter vpc"
resource "aws_route" "accepter" {
  #count = length(tolist(local.accepter_vpc_route_table_ids))
  for_each = toset(var.accepter_vpc_route_table_ids)

  route_table_id         = each.value                            # local.accepter_vpc_route_table_ids[count.index]                                    
  destination_cidr_block = var.requester_vpc_cidr                # data.aws_vpc.requester.cidr_block      
  vpc_peering_connection_id = aws_vpc_peering_connection.peering.id

}
