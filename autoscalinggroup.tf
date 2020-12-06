#Define autoscaling group#
resource "aws_autoscaling_group" "vc-asg-tf" {
  name = "vc-asg-tf"
  max_size = 3
  min_size = 0
  desired_capacity = 2
  launch_template {
    name= aws_launch_template.vc-lt-tf.name
    version = "$Latest"

  }
  #Define AZ#
  vpc_zone_identifier = [aws_subnet.public-subnet.id,aws_subnet.public-subnet2.id]
  target_group_arns = [aws_alb_target_group.vc-tg-tf.arn]
  health_check_type = "EC2"
  tag {
    key = "Name"
    propagate_at_launch = true
    value = "vc_asg-tf"
  }
}

