variable "aws_region" {
  description = "region for vpc"
  default = "us-east-1"
}

variable "vpc_cidr_vc" {
  description = "CIDR for VPC"
  default = "10.0.0.0/16"
}

variable "pb_sn_cidr_vc" {
  description = "CIDR public subnet"
  default = "10.0.1.0/24"
}

variable "pb2_sn_cidr_vc" {
  description = "CIDR public subnet 2"
  default = "10.0.3.0/24"
}

variable "pv_sn_cidr_vc" {
  description = "CIDR private subnet"
  default = "10.0.2.0/24"
}

variable "ami" {
  description = "Amazon Linux AMI"
  default = "ami-04d29b6f966df1537"
}

variable "key_path" {
  description = "SSH Public Key"
  default = "vc-key"
}

variable "instance_type" {
  description = "Instance type"
  default = "t1.micro"
}

variable "user_data" {
  description = "User data installing httpd"
  default = <<EOF
#!/bin/bash
yum install httpd -y
systemctl start httpd
systemctl stop firewalld
sudo echo "Hello World from $(hostname -f)" > /var/www/html/index.html
EOF

}



