data "template_file" "group_vars_all" {
  template = "${file("${path.module}/group_vars_all.tpl")}"

  vars {
    ssh_user       = "${aws_instance.nat.tags["sshUser"]}"
    ssh_public_dns = "${aws_instance.nat.public_dns}"
  }
}

resource "local_file" "group_vars_all" {
  content  = "${data.template_file.group_vars_all.rendered}"
  filename = "${path.module}/group_vars/all.yml"
}

resource "local_file" "flat_inventory" {
  content  = "${aws_instance.server01.private_dns}"
  filename = "${path.module}/flat_inventory"
}

resource "local_file" "ssh_proxyjump" {
  content  = "${aws_instance.nat.tags["sshUser"]}@${aws_instance.nat.public_dns}"
  filename = "${path.module}/ssh_proxyjump"
}

resource "local_file" "ssh_server01" {
  content  = "${aws_instance.server01.tags["sshUser"]}@${aws_instance.server01.private_dns}"
  filename = "${path.module}/ssh_server01"
}
