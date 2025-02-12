# create private route table 
resource "aws_route_table" "private" {
  vpc_id = var.vpc_id

  tags = merge(
    var.common_tags,
    {
      Name = "${var.resource_name}-private-RT"
    }
  )
  # depends_on = [aws_subnet.private]
}

# Route table entry to forward traffic to NAT instance (This is the main step)
resource "aws_route" "private_outbound_nat_route" {
  route_table_id         = aws_route_table.private.id
  destination_cidr_block = "0.0.0.0/0"
  network_interface_id   = aws_instance.nat_instance.primary_network_interface_id
}

resource "aws_route_table_association" "private" {
  count = length(var.private_subnet_cidr) > 0 ? length(var.private_subnet_cidr) : 0

  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private.id
}

