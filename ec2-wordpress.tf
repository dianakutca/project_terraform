
# 1. Create key pair
resource "aws_key_pair" "terraform-class" {
  key_name   = "terraform-ec2-class-key"
  public_key = file(var.path_to_public_key)
}

# 2. Create VM 
resource "aws_instance" "web" {
  availability_zone      = "us-east-1a"
  ami                    = "ami-09988af04120b3591"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.terraform-ec2.id]
  key_name               = aws_key_pair.terraform-class.key_name
  # user_data              = base64encode(file("install_apache.sh"))
  subnet_id = aws_subnet.public1.id
  tags = {
    "Name" : "wordpress"
  }
  # resource "null_resource" "copy_execute" {
  connection {
    type        = "ssh"
    user        = var.instance_username
    private_key = file(var.path_to_private_key)
    host        = aws_instance.web.public_ip
  }

  provisioner "remote-exec" {
    inline = [
      "sudo yum install php php-{pear,cgi,common,curl,mbstring,gd,mysqlnd,gettext,bcmath,json,xml,fpm,intl,zip}",
      "sudo amazon-linux-extras install php8.0 -y",
      "sudo yum install -y httpd mariadb-server",
      "sudo wget https://wordpress.org/latest.tar.gz",
      "sudo tar -xzf latest.tar.gz",
      "sudo systemctl start httpd",
      "sudo systemctl enable httpd",
      "sudo cp -r wordpress/* /var/www/html/",
      "sudo chown -R apache:apache /var/www/html/",
      "sudo mv /var/www/html/wp-config-sample.php /var/www/html/wp-config.php",
      "sudo sed -i 's/username_here/admin/g' /var/www/html/wp-config.php",
      "sudo sed -i 's/localhost/${aws_rds_cluster.diana.endpoint}/g' /var/www/html/wp-config.php",
      "sudo sed  -i 's/database_name_here/my_database/g' /var/www/html/wp-config.php",
      "sudo sed -i 's/database_name_here/my_database/g' /var/www/html/wp-config.php",
      "sudo sed  -i 's/password_here/barbut8chars/g' /var/www/html/wp-config.php"
    ]
  }
}
#     depends_on = [ aws_instance.web ]

# }

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

