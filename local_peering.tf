resource "aws_vpc_peering_connection" "sample_peer" {
  #peer_owner_id = var.peer_owner_id
  peer_vpc_id = aws_vpc.backend_vpc_sg.id
  vpc_id      = aws_vpc.frontend_vpc_sg.id
  auto_accept = true

  tags = {
    Name = "VPC Peering between frontend and backend"
  }
}
