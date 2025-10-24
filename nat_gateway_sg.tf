# ############################################
# # NAT Gateway (must live in the PUBLIC subnet)
# ############################################
# resource "aws_eip" "nat_eip_a" {
#   domain = "vpc"
#   tags   = { Name = "nat-eip-a" }
# }

# resource "aws_nat_gateway" "natgw_a" {
#   allocation_id = aws_eip.nat_eip_a.id
#   subnet_id     = aws_subnet.public_subnet_sg.id
#   tags          = { Name = "natgw-a" }

#   # Ensure the IGW exists before NATGW (so the public subnet is truly public)
#   depends_on = [aws_internet_gateway.igw_sg]
# }

# # NEW: EIP for your EC2 instance
# resource "aws_eip" "ec2_eip" {
#   domain   = "vpc"
#   instance = aws_instance.public_srv.id
#   tags     = { Name = "public-srv-eip" }
# }

############################################
# NAT Gateway (must live in the PUBLIC subnet)
############################################
resource "aws_eip" "nat_eip_a" {
  domain = "vpc"
  tags   = { Name = "nat-eip-a" }
}

resource "aws_nat_gateway" "natgw_a" {
  allocation_id = aws_eip.nat_eip_a.id
  subnet_id     = aws_subnet.frontend_private.id
  tags          = { Name = "natgw-a" }

  # Ensure the IGW exists before NATGW (so the public subnet is truly public)
  depends_on = [aws_internet_gateway.igw_sg]
}

# NEW: EIP for your EC2 instance
resource "aws_eip" "ec2_eip" {
  domain   = "vpc"
  instance = aws_instance.frontend_srv.id
  tags     = { Name = "public-srv-eip" }
}