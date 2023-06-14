resource "aws_ami_from_instance" "example" {
  name               = "terraform-example"
  source_instance_id = aws_instance.web.id
}