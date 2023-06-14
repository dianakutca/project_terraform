# Launch template

resource "aws_launch_template" "my_launch_template" {

  name = "my_launch_template"

  image_id      = aws_ami_from_instance.example.id
  instance_type = "t2.micro"
  key_name      = aws_key_pair.terraform-class.id


  network_interfaces {
    associate_public_ip_address = true
    security_groups             = [aws_security_group.my_sg.id]
  }
}

# Create ASG

resource "aws_autoscaling_group" "my_asg" {
  name              = "my_asg"
  max_size          = 5
  min_size          = 1
  health_check_type = "ELB"
  desired_capacity  = 1
  target_group_arns = [aws_alb_target_group.project-tg.arn]

  vpc_zone_identifier = [aws_subnet.public1.id, aws_subnet.public2.id, aws_subnet.public3.id]


  launch_template {
    id      = aws_launch_template.my_launch_template.id
    version = "$Latest"
  }
}
resource "aws_autoscaling_policy" "scale_up" {
  name                   = "scale_up"
  policy_type            = "SimpleScaling"
  autoscaling_group_name = aws_autoscaling_group.my_asg.name
  adjustment_type        = "ChangeInCapacity"
  scaling_adjustment     = "1"   # add one instance
  cooldown               = "300" # cooldown period after scaling
}

resource "aws_autoscaling_policy" "scale_down" {
  name                   = "asg-scale-down"
  autoscaling_group_name = aws_autoscaling_group.my_asg.name
  adjustment_type        = "ChangeInCapacity"
  scaling_adjustment     = "-1"
  cooldown               = "300"
  policy_type            = "SimpleScaling"
}