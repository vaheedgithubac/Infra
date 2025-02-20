output "ami_id" {
  value = data.aws_ami.amazon-linux2.id
}

output "ami_name" {
  value = data.aws_ami.amazon-linux2.name
}
