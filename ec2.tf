data "aws_ami" "amazonlinux" {
  most_recent = true
  owners      = ["137112412989"]

  filter {
    name   = "name"
    values = ["amzn-ami-hvm-*-x86_64-gp2"]
  }
}

resource "aws_instance" "server01" {
  connection {
    user     = "ec2-user"
    key_file = "${var.key_path}"
  }

  ami                    = "${data.aws_ami.amazonlinux.id}"
  instance_type          = "t2.micro"
  key_name               = "${aws_key_pair.awc_ssh_key.id}"
  vpc_security_group_ids = ["${aws_security_group.awc_def_sg.id}"]
  subnet_id              = "${aws_subnet.private_sn.id}"

  tags {
    Name    = "awc-ec2-private-server01"
    Owner   = "colemana"
    sshUser = "ec2-user"
  }
}
