#Define target group#
resource "aws_alb_target_group" "vc-tg-tf" {
  name = "vc-tg-tf"
  port = 80
  protocol = "HTTP"
  target_type = "instance"
  vpc_id = aws_vpc.vc_vpc_tf.id

  health_check {
    interval = 10
    path = "/"
    protocol = "HTTP"
    timeout = 5
    healthy_threshold = 5
    unhealthy_threshold = 2

  }
}

#Define ALB#
resource "aws_alb" "vc-alb-tf" {
  name = "vc-alb-tf"
  internal = false

 subnets = [
   aws_subnet.public-subnet.id,
   aws_subnet.public-subnet2.id
 ]
  security_groups = [aws_security_group.vc_sg_pub_tf.id]
  tags = {
    Name ="vc-alb-tf"
  }
  ip_address_type = "ipv4"
  load_balancer_type = "application"



}

#Define Listener#
resource "aws_lb_listener" "vc-list-alb-tf" {
  load_balancer_arn = aws_alb.vc-alb-tf.arn
  port = 80
  protocol = "HTTP"
  default_action {
    type = "forward"
    target_group_arn = aws_alb_target_group.vc-tg-tf.arn
  }
}



