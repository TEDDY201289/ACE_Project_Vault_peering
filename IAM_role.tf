# 1️⃣ IAM Role (trusts EC2)
resource "aws_iam_role" "ec2_ssm_role_1" {
  name = "EC2-SSM-Role_1"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })

  tags = {
    Name = "EC2-SSM-Role_1"
  }
}

# 2️⃣ Attach the AWS Managed Policy for SSM
resource "aws_iam_role_policy_attachment" "ssm_core" {
  role       = aws_iam_role.ec2_ssm_role_1.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

# 3️⃣ (Optional) If you want instance logs in CloudWatch, attach this too
# resource "aws_iam_role_policy_attachment" "cloudwatch_logs" {
#   role       = aws_iam_role.ec2_ssm_role.name
#   policy_arn = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
# }

# 4️⃣ Instance Profile (used by EC2 instances)
resource "aws_iam_instance_profile" "ec2_ssm_profile_1" {
  name = "EC2-SSM-Instance-Profile_1"
  role = aws_iam_role.ec2_ssm_role_1.name
}