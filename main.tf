provider "aws" {
  region = "${var.aws_region}"
}

resource "aws_key_pair" "awc_ssh_key" {
  key_name   = "${var.key_name}"
  public_key = "${file("${var.key_pub_path}")}"
}
