terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.82.2"
    }
  }
}
provider "aws" {
  region = "us-east-2"
}

locals {
  name = "jobin-john"
}

resource "aws_vpc" "joe-VPC" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "${local.name}-VPC "
  }
}

resource "aws_subnet" "subnet-main" {
  vpc_id     = aws_vpc.joe-VPC.id
  count      = 2
  cidr_block = "10.0.${count.index}.0/24"
  tags = {
    Name = "${local.name}-subnet-${count.index}"
  }

resource "aws_instance" "vm-main" {
  count         = 2
  ami           = var.ec2-main[count.index].ami
  instance_type = var.ec2-main[count.index].instance_type
  subnet_id     = element(aws_subnet.subnet-main[*].id, count.index % length(aws_subnet.subnet-main))
  tags = {
    Name = "${local.name}-VM-${count.index}"
  }
}


