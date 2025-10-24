resource "aws_route_table" "frontend_rt" {
  vpc_id = aws_vpc.frontend_vpc_sg.id

  tags = {
    Name = "frontend_rt"
  }
}

resource "aws_route_table" "backend_rt" {
  vpc_id = aws_vpc.backend_vpc_sg.id

  tags = {
    Name = "backend_rt"
  }
}

resource "aws_route_table_association" "frontend" {
  subnet_id      = aws_subnet.frontend_private.id
  route_table_id = aws_route_table.public_rt_sg.id
  
}

resource "aws_route_table_association" "backend" {
  subnet_id      = aws_subnet.backend_private.id
  route_table_id = aws_route_table.backend_rt.id
}