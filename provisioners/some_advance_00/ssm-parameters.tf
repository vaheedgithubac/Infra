# Store private key as SecureString in SSM Parameter Store
resource "aws_ssm_parameter" "private_key" {
  name        = "/backend/ssh/private-key"
  description = "The private SSH key for EC2 instance"
  type        = "SecureString"
  value       = filebase64("private_key") # Directly read and encrypt to base64 
  #   value       = file("private_key")
}

output "private_key_ssm_parameter" {
  value = aws_ssm_parameter.private_key.name
}
