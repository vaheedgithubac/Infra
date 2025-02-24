module "ec2" {
  source = "git::https://github.com/vaheedgithubac/Infra.git//modules/ec2"

  ami_id                      = "ami-0d682f26195e9ec0f"
  public_key_name             = "mumbai-1"
  sg_id                       = ["sg-052d3213d9d587ce1"]
  subnet_id                   = "subnet-088e8443a70102e2a" # "subnet-088e8443a70102e2a" #1a
  associate_public_ip_address = true
  is_nat_instance             = false # creates NAT instance if true
  # user_data                   = file("${path.module}/nat_user_data.sh")

  project_name = var.project_name
  env          = var.env
  common_tags  = var.common_tags
}

resource "null_resource" "backend" {
  # Changes to any instance of the instance requires re-provisioning
  triggers = {
    instance_id = module.ec2.instance_id
  }

  # Bootstrap script can run on any instance of the cluster
  # So we just choose the first in this case
  connection {
    host        = module.ec2.ec2_instance.private_ip #aws_instance.backend.private_ip
    type        = "ssh"
    user        = "ec2-user"
    private_key = base64decode(data.aws_ssm_parameter.private_key.value)

    # private_key = data.aws_ssm_parameter.private_key.value
    # password = "DevOps321"
  }

  provisioner "file" {
    source      = "backend.sh"
    destination = "/tmp/backend.sh"
  }

  provisioner "remote-exec" {
    # Bootstrap script called with private_ip of each node in the cluster
    inline = [
      "chmod +x /tmp/backend.sh",
      "sudo sh /tmp/backend.sh "
    ]
  }
  depends_on = [aws_ssm_parameter.private_key]
}
