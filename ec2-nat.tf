resource "aws_instance" "nat" {
  ami                    = "${data.aws_ami.nat.id}"
  instance_type          = "${var.ec2-nat-instance-type}"
  subnet_id              = "${aws_subnet.public_sn.id}"
  vpc_security_group_ids = ["${aws_security_group.nat_sg.id}"]
  source_dest_check      = false
  key_name               = "${aws_key_pair.awc_ssh_key.id}"

  tags {
    Name    = "awc-nat-instance"
    Owner   = "colemana"
    sshUser = "ec2-user"
  }
}

resource "aws_security_group" "nat_sg" {
  name        = "awc-nat-sg"
  description = "Default security group to allow inbound/outbound from the VPC"
  vpc_id      = "${aws_vpc.vpc.id}"

  # SSH access from anywhere
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = "0"
    to_port     = "0"
    protocol    = "-1"
    cidr_blocks = ["${var.private_subnet_cidr}"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name  = "awc-nat-sg"
    Owner = "colemana"
  }
}

# Route for Private subnet to NAT instance
resource "aws_route_table" "nat_rt_table" {
  vpc_id = "${aws_vpc.vpc.id}"

  tags {
    Name  = "awc-nat-rt-table"
    Owner = "colemana"
  }
}

resource "aws_route" "nat_rt" {
  route_table_id         = "${aws_route_table.nat_rt_table.id}"
  destination_cidr_block = "0.0.0.0/0"
  instance_id            = "${aws_instance.nat.id}"
}

resource "aws_route_table_association" "nat_rt_assoc" {
  subnet_id      = "${aws_subnet.private_sn.id}"
  route_table_id = "${aws_route_table.nat_rt_table.id}"
}
