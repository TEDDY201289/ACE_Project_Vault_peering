############################################
# Internet Gateway (attach to your VPC)
############################################
resource "aws_internet_gateway" "igw_sg" {
  vpc_id = aws_vpc.frontend_vpc_sg.id
  tags   = { Name = "igw_sg" }
}