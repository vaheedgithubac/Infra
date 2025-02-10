output "ami_id" {
  value = data.aws_ami.amzn_linux_2023_ami.id
}

output "ami_name" {
  value = data.aws_ami.amzn_linux_2023_ami.name
}
