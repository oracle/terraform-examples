resource "oci_core_subnet" "sub01be" {
  availability_domain = "${lookup(data.oci_identity_availability_domains.ADs.availability_domains[0],"name")}"
  cidr_block          = "${var.vcn_vpn_subnets_cidr_blocks[0]}"
  display_name        = "sub01be"
  dns_label           = "sub01be"
  security_list_ids   = ["${oci_core_security_list.security_list_default.id}"]
  compartment_id      = "${var.compartment_ocid}"
  vcn_id              = "${oci_core_virtual_network.vcn_vpn.id}"
  route_table_id      = "${oci_core_route_table.routing_table_default.id}"
  dhcp_options_id     = "${oci_core_virtual_network.vcn_vpn.default_dhcp_options_id}"

  provisioner "local-exec" {
    command = "sleep 3"
  }
}

resource "oci_core_subnet" "sub02be" {
  availability_domain = "${lookup(data.oci_identity_availability_domains.ADs.availability_domains[1],"name")}"
  cidr_block          = "${var.vcn_vpn_subnets_cidr_blocks[1]}"
  display_name        = "sub02be"
  dns_label           = "sub02be"
  security_list_ids   = ["${oci_core_security_list.security_list_default.id}"]
  compartment_id      = "${var.compartment_ocid}"
  vcn_id              = "${oci_core_virtual_network.vcn_vpn.id}"
  route_table_id      = "${oci_core_route_table.routing_table_default.id}"
  dhcp_options_id     = "${oci_core_virtual_network.vcn_vpn.default_dhcp_options_id}"

  provisioner "local-exec" {
    command = "sleep 3"
  }
}

resource "oci_core_subnet" "sub03be" {
  availability_domain = "${lookup(data.oci_identity_availability_domains.ADs.availability_domains[2],"name")}"
  cidr_block          = "${var.vcn_vpn_subnets_cidr_blocks[2]}"
  display_name        = "sub03be"
  dns_label           = "sub03be"
  security_list_ids   = ["${oci_core_security_list.security_list_default.id}"]
  compartment_id      = "${var.compartment_ocid}"
  vcn_id              = "${oci_core_virtual_network.vcn_vpn.id}"
  route_table_id      = "${oci_core_route_table.routing_table_default.id}"
  dhcp_options_id     = "${oci_core_virtual_network.vcn_vpn.default_dhcp_options_id}"

  provisioner "local-exec" {
    command = "sleep 3"
  }
}
