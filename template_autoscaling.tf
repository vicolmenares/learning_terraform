#Define launch template for the autoscaling#
resource "aws_launch_template" "vc-lt-tf" {
  name = "vc-lt-tf"
  description = "Template from terraform"
  image_id = var.ami
  instance_initiated_shutdown_behavior = "terminate"
  instance_type = var.instance_type
  key_name = "vc-key"
  default_version = 1
  user_data = filebase64("${path.module}/install_apache.sh")



  network_interfaces {
    associate_public_ip_address = "true"
    security_groups = [aws_security_group.vc_sg_pub_tf.id]

  }

  tags = {
    Name = "vc_lt_tf"
  }

}






