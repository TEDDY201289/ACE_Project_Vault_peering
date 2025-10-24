##############################
# Security Group for Endpoints
##############################
resource "aws_security_group" "frontend_security" {
  vpc_id = aws_vpc.frontend_vpc_sg.id
  name   = "frontend_security"

  ingress {
    description = "Allow HTTPS from inside VPC"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"] # <-- replace with your VPC CIDR
  }
  ingress {
    description = "Allow ICMP Echo Request (ping)"
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["20.0.0.0/16"] # or restrict to your network (e.g., "10.0.0.0/16")
  }


  egress {
    description = "Allow all outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "frontend_security"
  }
}


##############################
# Security Group for Endpoints
##############################
resource "aws_security_group" "backend_security" {
  vpc_id = aws_vpc.backend_vpc_sg.id
  name   = "backend_security"

  ingress {
    description = "Allow ICMP Echo Request (ping)"
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["10.0.0.0/16"] # or restrict to your network (e.g., "10.0.0.0/16")
  }
  ingress {
    description = "Allow HTTPS from inside VPC"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["20.0.0.0/16"] # <-- replace with your VPC CIDR
  }
  # Vault HTTP
  ingress {
    description = "Vault HTTP"
    from_port   = 8200
    to_port     = 8200
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # tighten in real use
  }

  egress {
    description = "Allow all outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "backend_security"
  }
}

# ##############################
# # Security Group for Endpoints
# ##############################
# resource "aws_security_group" "public_security" {
#   vpc_id = aws_vpc.public_vpc_sg.id
#   name   = "public_security"

#   ingress {
#     description = "Allow ICMP Echo Request (ping)"
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"] # or restrict to your network (e.g., "10.0.0.0/16")
#   }

#   egress {
#     description = "Allow all outbound"
#     from_port   = 443
#     to_port     = 443
#     protocol    = "TCP"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   tags = {
#     Name = "public_security"
#   }
# }