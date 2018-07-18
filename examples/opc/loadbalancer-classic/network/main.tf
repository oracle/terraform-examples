
resource "opc_compute_ip_network" "ipnetwork" {
  name              = "${var.name}"
  ip_address_prefix = "${var.cidr}"
}
