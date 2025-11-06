# Query vpc_id from AWS_SSM_PARAMETER store
# in /<project_name>/<env>/<vpc_id>

data "aws_ssm_parameter" "requester_vpc_id" {
  name = var.requester_vpc_id
  #depends_on = [ module.vpc.aws_ssm_parameter.vpc_id ]
}

data "aws_ssm_parameter" "accepter_vpc_id" {
  name = var.accepter_vpc_id
  #depends_on = [ module.vpc.aws_ssm_parameter.vpc_id ]
}

data "aws_route_tables" "requester" {
  vpc_id = data.aws_ssm_parameter.requester_vpc_id.value
  #depends_on = [ module.vpc.vpc_id ]
}

data "aws_route_tables" "accepter" {
  vpc_id = data.aws_ssm_parameter.accepter_vpc_id.value
  #depends_on = [ module.vpc.vpc_id ]
}
