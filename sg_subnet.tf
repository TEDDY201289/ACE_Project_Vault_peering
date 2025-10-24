resource "aws_subnet" "frontend_private" {
  vpc_id     = aws_vpc.frontend_vpc_sg.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "frontend_private"
  }
}

resource "aws_subnet" "backend_private" {
  vpc_id     = aws_vpc.backend_vpc_sg.id
  cidr_block = "20.0.1.0/24"

  tags = {
    Name = "backend_private"
  }
}

# resource "aws_subnet" "public_subnet_sg" {
#   vpc_id     = aws_vpc.public_vpc_sg.id
#   cidr_block = "50.0.1.0/24"

#   tags = {
#     Name = "public_subnet_sg"
#   }
# }