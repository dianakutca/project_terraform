# Application Load Balancer
resource "aws_alb" "application-lb" {
  name               = "project-alb"
  internal           = false
  ip_address_type    = "ipv4"
  load_balancer_type = "application"
  security_groups    = [aws_security_group.my_sg.id]
  subnets            = [aws_subnet.public1.id, aws_subnet.public2.id, aws_subnet.public3.id]
}

# Target group
resource "aws_alb_target_group" "project-tg" {

  name        = "project-tg"
  port        = 80
  protocol    = "HTTP"
  target_type = "instance"
  vpc_id      = aws_vpc.Project.id

  health_check {
    interval            = 30
    path                = "/"
    protocol            = "HTTP"
    port                = 80
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 3
    matcher             = 302

  }
}

# Creating Listener
resource "aws_alb_listener" "alb-listener" {
  load_balancer_arn = aws_alb.application-lb.arn
  port              = 80
  protocol          = "HTTP"
  default_action {
    target_group_arn = aws_alb_target_group.project-tg.arn
    type             = "forward"
  }
}

