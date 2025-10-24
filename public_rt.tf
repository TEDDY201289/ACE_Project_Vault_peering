# ############################################
# # Public Route Table -> IGW
# ############################################
# resource "aws_route_table" "public_rt_sg" {
#   vpc_id = aws_vpc.public_vpc_sg.id
#   tags   = { Name = "public-rt-sg" }
# }

# resource "aws_route" "public_default_to_igw" {
#   route_table_id         = aws_route_table.public_rt_sg.id
#   destination_cidr_block = "0.0.0.0/0"
#   gateway_id             = aws_internet_gateway.igw_sg.id
# }

# # Associate public subnet to the public route table
# resource "aws_route_table_association" "public_assoc_sg" {
#   subnet_id      = aws_subnet.public_subnet_sg.id
#   route_table_id = aws_route_table.public_rt_sg.id
# }