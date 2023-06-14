resource "aws_db_subnet_group" "project_db_subnet_group" {
  name       = "project_db_subnet_group"
  subnet_ids = [aws_subnet.private1.id, aws_subnet.private2.id, aws_subnet.private3.id]
}

resource "aws_rds_cluster_instance" "cluster_instances" {
  count              = 1
  cluster_identifier = aws_rds_cluster.diana.id
  instance_class     = "db.r4.large"
  engine             = "aurora-mysql"
  db_subnet_group_name = aws_db_subnet_group.project_db_subnet_group.id
}

resource "aws_rds_cluster" "diana" {
  cluster_identifier     = "database-1"
  engine                 = "aurora-mysql"
  availability_zones     = ["us-east-1a", "us-east-1b", "us-east-1c"]
  database_name          = "my_database"
  master_username        = "admin"
  master_password        = "barbut8chars"
  vpc_security_group_ids = [aws_security_group.db_sg.id]
  skip_final_snapshot    = true
    db_subnet_group_name = aws_db_subnet_group.project_db_subnet_group.id
  #   writer                 = true

}

resource "aws_security_group" "db_sg" {
  name        = "db-sg"
  description = "Allow MySQL access from EC2 instance"
      vpc_id      = aws_vpc.Project.id

  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
        cidr_blocks = ["0.0.0.0/0"]

  }
}

# resource "aws_db_instance" "project_database" {
#   allocated_storage    = 10
#   db_name              = "project_database"
#   engine               = "mysql"
#   engine_version       = "5.7"
#   instance_class       = "db.t3.micro"
#   username             = "admin"
#   password             = "admin"
#   db_subnet_group_name = aws_db_subnet_group.project_db_subnet_group.id
#   skip_final_snapshot  = true

# }