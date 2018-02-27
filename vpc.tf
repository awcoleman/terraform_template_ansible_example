resource "aws_vpc" "vpc" {
  cidr_block           = "${var.vpc_cidr}"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags {
    Name  = "awc-vpc"
    Owner = "colemana"
  }
}

resource "aws_internet_gateway" "ig" {
  vpc_id = "${aws_vpc.vpc.id}"

  tags {
    Name  = "awc-ig"
    Owner = "colemana"
  }
}

# Grant the VPC internet access on its main route table
resource "aws_route_table" "internet_access_rt" {
  vpc_id = "${aws_vpc.vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.ig.id}"
  }

  tags {
    Name  = "awc-ig"
    Owner = "colemana"
  }
}

resource "aws_route_table_association" "internet_access_rt_assoc" {
  subnet_id      = "${aws_subnet.public_sn.id}"
  route_table_id = "${aws_route_table.internet_access_rt.id}"
}

# Create a public subnet to launch our instances into
resource "aws_subnet" "public_sn" {
  vpc_id                  = "${aws_vpc.vpc.id}"
  cidr_block              = "${var.public_subnet_cidr}"
  map_public_ip_on_launch = true

  tags {
    Name  = "awc-public-sn"
    Owner = "colemana"
  }
}

# Create a private subnet to launch our instances into
resource "aws_subnet" "private_sn" {
  vpc_id     = "${aws_vpc.vpc.id}"
  cidr_block = "${var.private_subnet_cidr}"

  tags {
    Name  = "awc-private-sn"
    Owner = "colemana"
  }
}

# Our default security group to access the instances over SSH
resource "aws_security_group" "awc_def_sg" {
  name        = "awc-def-sg"
  description = "Basic SG"
  vpc_id      = "${aws_vpc.vpc.id}"

  # SSH access from anywhere
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8
    to_port     = 0
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # outbound internet access
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name  = "awc-def-sg"
    Owner = "colemana"
  }
}
