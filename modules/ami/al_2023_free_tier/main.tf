data "aws_ami" "amzn_linux_2023_ami" {
  most_recent      = true
  owners           = ["amazon"]

  filter {
    name   = "name"
    # values = ["al2023-ami-2023.*-x86_64"]
    values = ["*-ami-2023.*-x86_64"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

}

######################################################################
# data "aws_ami" "amzn_linux_2023_ami" {
# most_recent = true
#  owners      = ["amazon"]

#  filter {
#    name   = "name"
#   values = ["al2023-ami-2023.*-x86_64"]
#  }
# }


