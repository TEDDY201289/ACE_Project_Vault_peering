# # FRONTEND VPC (10.0.0.0/16)
# resource "aws_vpc" "frontend_vpc_sg" {
#   cidr_block           = "10.0.0.0/16"
#   enable_dns_support   = true
#   enable_dns_hostnames = true
#   tags                 = { Name = "frontend-vpc-sg" }
# }

# # FRONTEND VPC (10.0.0.0/16)
# resource "aws_vpc" "backend_vpc_sg" {
#   cidr_block           = "20.0.0.0/16"
#   enable_dns_support   = true
#   enable_dns_hostnames = true
#   tags                 = { Name = "backend-vpc-sg" }
# }

resource "aws_vpc" "frontend_vpc_sg" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name   = "frontend_vpc_sg"
    Region = "ap-southeast-1"
  }
}

resource "aws_vpc" "backend_vpc_sg" {
  cidr_block           = "20.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name   = "backend_vpc_sg"
    Region = "ap-southeast-1"
  }
}

# resource "aws_vpc" "public_vpc_sg" {
#   cidr_block           = "50.0.0.0/16"
#   enable_dns_support   = true
#   enable_dns_hostnames = true
#   tags = {
#     Name   = "public_vpc_sg"
#     Region = "ap-southeast-1"
#   }
# }