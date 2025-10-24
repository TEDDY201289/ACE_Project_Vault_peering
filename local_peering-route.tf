


# Create a routetable for peering (Frontend)
resource "aws_route" "frontend_peer_rt" {
  route_table_id            = aws_route_table.frontend_rt.id
  destination_cidr_block    = "20.0.0.0/16"
  vpc_peering_connection_id = aws_vpc_peering_connection.sample_peer.id
}

# Create a routetable for peering
resource "aws_route" "backend_peer_rt" {
  route_table_id            = aws_route_table.backend_rt.id
  destination_cidr_block    = "10.0.0.0/16"
  vpc_peering_connection_id = aws_vpc_peering_connection.sample_peer.id
}