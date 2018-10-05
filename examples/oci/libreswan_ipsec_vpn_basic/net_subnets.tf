resource "oci_core_subnet" "subnet01" {
  availability_domain = "${lookup(data.oci_identity_availability_domains.ads.availability_domains[0],"name")}"
  cidr_block          = "${var.vcn_vpn_subnets_cidr_blocks[0]}"
  display_name        = "subnet01"
  dns_label           = "sub01"
  security_list_ids   = ["${oci_core_security_list.security_list_default.id}","${oci_core_security_list.local_sec_list_01.id}"]
  compartment_id      = "${var.compartment_ocid}"
  vcn_id              = "${oci_core_virtual_network.vcn_vpn.id}"
  route_table_id      = "${oci_core_route_table.routing_table_default.id}"
  dhcp_options_id     = "${oci_core_virtual_network.vcn_vpn.default_dhcp_options_id}"

  provisioner "local-exec" {
    command = "sleep 3"
  }
}

resource "oci_core_subnet" "subnet02" {
  availability_domain = "${lookup(data.oci_identity_availability_domains.ads.availability_domains[1],"name")}"
  cidr_block          = "${var.vcn_vpn_subnets_cidr_blocks[1]}"
  display_name        = "subnet02"
  dns_label           = "sub02"
  security_list_ids   = ["${oci_core_security_list.security_list_default.id}","${oci_core_security_list.local_sec_list_02.id}"]
  compartment_id      = "${var.compartment_ocid}"
  vcn_id              = "${oci_core_virtual_network.vcn_vpn.id}"
  route_table_id      = "${oci_core_route_table.routing_table_default.id}"
  dhcp_options_id     = "${oci_core_virtual_network.vcn_vpn.default_dhcp_options_id}"

  provisioner "local-exec" {
    command = "sleep 3"
  }
}

resource "oci_core_subnet" "subnet03" {
  availability_domain = "${lookup(data.oci_identity_availability_domains.ads.availability_domains[2],"name")}"
  cidr_block          = "${var.vcn_vpn_subnets_cidr_blocks[2]}"
  display_name        = "subnet03"
  dns_label           = "sub03"
  security_list_ids   = ["${oci_core_security_list.security_list_default.id}","${oci_core_security_list.local_sec_list_03.id}"]
  compartment_id      = "${var.compartment_ocid}"
  vcn_id              = "${oci_core_virtual_network.vcn_vpn.id}"
  route_table_id      = "${oci_core_route_table.routing_table_default.id}"
  dhcp_options_id     = "${oci_core_virtual_network.vcn_vpn.default_dhcp_options_id}"

  provisioner "local-exec" {
    command = "sleep 3"
  }
}
