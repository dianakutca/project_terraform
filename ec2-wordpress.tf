
# 1. Create key pair
resource "aws_key_pair" "terraform-class" {
  key_name   = "terraform-ec2-class-key"
  public_key = file(var.path_to_public_key)
}

# 2. Create VM 
resource "aws_instance" "web" {
  availability_zone      = "us-east-1a"
  ami                    = "ami-04a0ae173da5807d3"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.terraform-ec2.id]
  key_name               = aws_key_pair.terraform-class.key_name
  user_data              = base64encode(file("install_apache.sh"))

  subnet_id                   = aws_subnet.public1.id
  associate_public_ip_address = true

  tags = {
    "Name" : "wordpress"
  }

  connection {
    type        = "ssh"
    user        = var.instance_username
    private_key = file(var.path_to_private_key)
    host        = self.public_ip
  }

  provisioner "remote-exec" {

    inline = [
      "#!/bin/bash",
      "FILE_PATH=\"/var/www/html/wp-config.php\"",
      "CONTENT=$(cat $FILE_PATH)",
      "UPDATED_CONTENT=$(echo \"$CONTENT\" | \\",
      "                  sed -e \"s/'username_here'/'admin'/\" \\",
      "                      -e \"s/'localhost'/'${aws_rds_cluster.diana.endpoint}'/\" \\",
      "                      -e \"s/'database_name_here'/'my_database'/\" \\",
      "                      -e \"s/'password_here'/'barbut8chars'/\")",
      "echo \"$UPDATED_CONTENT\" > $FILE_PATH",
    ]
  }
}

#3. Create sec group
resource "aws_security_group" "terraform-ec2" {
  name        = "terraform-ec2"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.Project.id

  ingress {
    description = "SSH access"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}

