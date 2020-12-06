#Define webserver inside public subnet#
resource "aws_instance" "vc_web_server_tf" {
  ami = "${var.ami}"
  instance_type = "${var.instance_type}"
  key_name = "vc-key"
  subnet_id = "${aws_subnet.public-subnet.id}"
  vpc_security_group_ids = ["${aws_security_group.vc-sgpub.id}"]
  associate_public_ip_address = true
  source_dest_check = false
  user_data = "${var.user_data}"
  tags = {
    Name ="vc_web_server_tf"
  }

}



resource "aws_instance" "vc_db_server_tf" {
  ami = "${var.ami}"
  instance_type = "${var.instance_type}"
  key_name = "vc-key"
  subnet_id = "${aws_subnet.private-subnet.id}"
  vpc_security_group_ids = ["${aws_security_group.vc-sgpriv.id}"]
  source_dest_check = false
  tags = {
    Name ="vc_db_server_tf"
  }
}
