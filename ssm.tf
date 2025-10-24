##############################
# Interface Endpoints (SSM / SSM Messages / EC2 Messages)
##############################

# 1️⃣ SSM
resource "aws_vpc_endpoint" "ssm" {
  vpc_id              = aws_vpc.frontend_vpc_sg.id
  service_name        = "com.amazonaws.ap-southeast-1.ssm"
  vpc_endpoint_type   = "Interface"
  subnet_ids          = [aws_subnet.frontend_private.id]
  security_group_ids  = [aws_security_group.frontend_security.id]
  private_dns_enabled = true

  tags = {
    Name = "vpc_endpoint_ssm"
  }
}

# 2️⃣ SSM Messages
resource "aws_vpc_endpoint" "ssmmessages" {
  vpc_id              = aws_vpc.frontend_vpc_sg.id
  service_name        = "com.amazonaws.ap-southeast-1.ssmmessages"
  vpc_endpoint_type   = "Interface"
  subnet_ids          = [aws_subnet.frontend_private.id]
  security_group_ids  = [aws_security_group.frontend_security.id]
  private_dns_enabled = true

  tags = {
    Name = "vpc_endpoint_ssmmessages"
  }
}

# 3️⃣ EC2 Messages
resource "aws_vpc_endpoint" "ec2messages" {
  vpc_id              = aws_vpc.frontend_vpc_sg.id
  service_name        = "com.amazonaws.ap-southeast-1.ec2messages"
  vpc_endpoint_type   = "Interface"
  subnet_ids          = [aws_subnet.frontend_private.id]
  security_group_ids  = [aws_security_group.frontend_security.id]
  private_dns_enabled = true

  tags = {
    Name = "vpce-ec2messages"
  }
}

#==========================================================================================

# ##############################
# # Interface Endpoints (SSM / SSM Messages / EC2 Messages)
# ##############################

# # 1️⃣ SSM
# resource "aws_vpc_endpoint" "ssm_backend" {
#   vpc_id              = aws_vpc.backend_vpc_sg.id
#   service_name        = "com.amazonaws.ap-southeast-1.ssm"
#   vpc_endpoint_type   = "Interface"
#   subnet_ids          = [aws_subnet.backend_private.id]
#   security_group_ids  = [aws_security_group.backend_security.id]
#   private_dns_enabled = true

#   tags = {
#     Name = "vpc_backend_endpoint_ssm"
#   }
# }

# # 2️⃣ SSM Messages
# resource "aws_vpc_endpoint" "ssmmessages_backend" {
#   vpc_id              = aws_vpc.backend_vpc_sg.id
#   service_name        = "com.amazonaws.ap-southeast-1.ssmmessages"
#   vpc_endpoint_type   = "Interface"
#   subnet_ids          = [aws_subnet.backend_private.id]
#   security_group_ids  = [aws_security_group.backend_security.id]
#   private_dns_enabled = true

#   tags = {
#     Name = "vpc_backend_endpoint_ssmmessages"
#   }
# }

# # 3️⃣ EC2 Messages
# resource "aws_vpc_endpoint" "ec2messages_backend" {
#   vpc_id              = aws_vpc.backend_vpc_sg.id
#   service_name        = "com.amazonaws.ap-southeast-1.ec2messages"
#   vpc_endpoint_type   = "Interface"
#   subnet_ids          = [aws_subnet.backend_private.id]
#   security_group_ids  = [aws_security_group.backend_security.id]
#   private_dns_enabled = true

#   tags = {
#     Name = "vpce-backend-ec2messages"
#   }
# }