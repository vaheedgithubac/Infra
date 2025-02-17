resource "tls_private_key" "tf_generated_private_key" {
  algorithm = "RSA"
  rsa_bits  = "4096"
}

resource "aws_key_pair" "generated" {
  key_name   = "tf_aws_key_pair"
  public_key = tls_private_key.tf_generated_private_key.public_key_openssh

  provisioner "local-exec" {
    command = <<-EOF
      echo "Current working Directory......{path.module}"
      echo "${tls_private_key.tf_generated_private_key.private_key_pem}" > ${path.module}/tf_aws_key_pair.pem
      chmod 400 tf_aws_key_pair.pem
      echo "Private key created at ${path.module}/tf_aws_key_pair.pem"
    EOF
  }
}

