
output "ec2_instance" {
  value = aws_instance.ec2_instance
}

output "instance_id" {
  value = aws_instance.ec2_instance.id
}

output "primary_network_interface_id" {
  value = aws_instance.ec2_instance.primary_network_interface_id
}
