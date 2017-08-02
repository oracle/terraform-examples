provider "opc" {
  user            = "${var.user}"
  password        = "${var.password}"
  identity_domain = "${var.domain}"
  endpoint        = "${var.endpoint}"
}

resource "opc_compute_instance" "instance1" {
  name       = "example-instance1"
  label      = "My Oracle Linux 7.2 UEK3 Server"
  shape      = "oc3"
  image_list = "/oracle/public/OL_7.2_UEKR3_x86_64"
  ssh_keys   = ["${opc_compute_ssh_key.sshkey1.name}"]
}

resource "opc_compute_ssh_key" "sshkey1" {
  name    = "example-sshkey1"
  key     = "${file(var.ssh_public_key_file)}"
  enabled = true
}

resource "opc_compute_ip_reservation" "ipreservation1" {
  parent_pool = "/oracle/public/ippool"
  permanent   = true
}

resource "opc_compute_ip_association" "instance1-ipreservation" {
  vcable      = "${opc_compute_instance.instance1.vcable}"
  parent_pool = "ipreservation:${opc_compute_ip_reservation.ipreservation1.name}"
}
