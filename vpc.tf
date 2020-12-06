#Define our VPC#
resource "aws_vpc" "vc_vpc_tf" {
  cidr_block = var.vpc_cidr_vc
  enable_dns_hostnames = true
  tags = {
    Name ="vc_vpc_tf"
  }

}

#Define public subnets 1#
resource "aws_subnet" "public-subnet" {
  cidr_block = var.pb_sn_cidr_vc
  vpc_id = aws_vpc.vc_vpc_tf.id
  availability_zone = "us-east-1a"
  tags = {
    Name ="vc_pub_sn_tf"
  }
}

#Define public subnet 2#
resource "aws_subnet" "public-subnet2" {
  cidr_block = var.pb2_sn_cidr_vc
  vpc_id = aws_vpc.vc_vpc_tf.id
  availability_zone = "us-east-1b"
  tags = {
    Name= "vc_pub2_sn_tf"
  }
}

#Define Internet Gateway#
resource "aws_internet_gateway" "vc_vpc_igw_tf" {
  vpc_id = aws_vpc.vc_vpc_tf.id
  tags = {
    Name ="vc_vpc_igw_tf"
  }
}

#Define route table#
resource "aws_route_table" "rt-public" {
  vpc_id = aws_vpc.vc_vpc_tf.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.vc_vpc_igw_tf.id
  }
  tags = {
    Name ="vc_pub_sn_rt_tf"
  }
}

#Assing RT to public Subnet#
resource "aws_route_table_association" "rt-public-sn1" {
  route_table_id = aws_route_table.rt-public.id
  subnet_id = aws_subnet.public-subnet.id
}
resource "aws_route_table_association" "rt-public-sn2" {
  route_table_id = aws_route_table.rt-public.id
  subnet_id = aws_subnet.public-subnet2.id
}


#Define Security Group for public subnet#
resource "aws_security_group" "vc_sg_pub_tf" {
  name = "vc_sg_pub_tf"
  description = "Allow inconming HTTP connections and SSH access"
  ingress {
    from_port = 80
    protocol = "tcp"
    to_port = 80
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port = 443
    protocol = "tcp"
    to_port = 443
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port = -1
    protocol = "icmp"
    to_port = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port = 22
    protocol = "tcp"
    to_port = 22
    cidr_blocks = ["0.0.0.0/0"]


  }
  egress {
    from_port = 0
    protocol = "-1"
    to_port = 0
    cidr_blocks = ["0.0.0.0/0"]

  }
  vpc_id = aws_vpc.vc_vpc_tf.id
  tags = {
    Name ="vc_sg_pub_tf"

  }

}

#Define Security Group private subnet#
resource "aws_security_group" "vc-sg_priv_tf" {
  name = "vc_sg_priv_tf"
  description = "Allow traffic from public subnet for DB servers"

  ingress {
    from_port = 3306
    protocol = "tcp"
    to_port = 3306
    cidr_blocks = [var.pb_sn_cidr_vc]
  }
  ingress {
    from_port = -1
    protocol = "icmp"
    to_port = -1
    cidr_blocks = [var.pb_sn_cidr_vc]
  }
  ingress {
    from_port = 22
    protocol = "tcp"
    to_port = 22
    cidr_blocks = [var.pb_sn_cidr_vc]
  }
  vpc_id = aws_vpc.vc_vpc_tf.id
  tags = {
    Name ="vc_db_sg_tf"

  }

}







