terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

#configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}

data "aws_vpc" "selected" {
  id = "vpc-0b645c2bcc92b68ba"
}
#create an instance
resource "aws_instance" "VC_Terraform_Server" {
  ami = "ami-04d29b6f966df1537"
  instance_type = "t2.micro"
  subnet_id = "subnet-07a80bf3d886a60d4"
  security_groups = ["sg-089f603ae057c6c76"]
  associate_public_ip_address = true
  key_name = "vc-key"
  tags = {
    Name="VC-Terraform-server"
    User="VC"
  }



}
