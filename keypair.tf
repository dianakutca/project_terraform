# 1. Create key pair

resource "aws_key_pair" "project_keypair" {
  key_name   = "project_keypair"
  public_key = file(var.path_to_public_key)
}