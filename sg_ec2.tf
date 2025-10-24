# Frontend server
resource "aws_instance" "frontend_srv" {
  ami                    = "ami-0ffd8e96d1336b6ac" # replace
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.frontend_private.id
  vpc_security_group_ids = [aws_security_group.frontend_security.id]
  # key_name               = "my-ec2-key"
  iam_instance_profile = aws_iam_instance_profile.ec2_ssm_profile_1.name

  # Run the installer on first boot
  user_data = file("${path.module}/vault_install.sh")

  tags = { Name = "frontend-srv" }
}

resource "aws_instance" "backend_srv" {
  ami                    = "ami-0ffd8e96d1336b6ac" # replace
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.backend_private.id
  vpc_security_group_ids = [aws_security_group.backend_security.id]
  # key_name               = "my-ec2-key"
  iam_instance_profile = aws_iam_instance_profile.ec2_ssm_profile_1.name
  tags                 = { Name = "backend-srv" }
}

# resource "aws_instance" "public_srv" {
#   ami                    = "ami-0ffd8e96d1336b6ac" # replace
#   instance_type          = "t2.micro"
#   subnet_id              = aws_subnet.public_subnet_sg.id
#   vpc_security_group_ids = [aws_security_group.public_security.id]
#   # key_name               = "my-ec2-key"
#   # depends_on             = [aws_key_pair.Frontend_public_key]
#   iam_instance_profile = aws_iam_instance_profile.ec2_ssm_profile_1.name
#   tags                 = { Name = "public_srv" }
# }
