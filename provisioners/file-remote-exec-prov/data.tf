data "aws_ssm_parameter" "private_key" {
  name            = "/backend/ssh/private-key"
  with_decryption = true
  depends_on      = [aws_ssm_parameter.private_key]
}
