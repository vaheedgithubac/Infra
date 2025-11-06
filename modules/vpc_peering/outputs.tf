output "requester_vpc_id" {
  value = data.aws_ssm_parameter.requester_vpc_id.value
  sensitive = true
}
