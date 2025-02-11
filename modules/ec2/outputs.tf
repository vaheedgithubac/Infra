
output "ec2_instance" {
  value = aws_instance.ec2_instance
}

output "instance_id" {
  value = aws_instance.ec2_instance.id
}

