resource "oci_core_virtual_network" "vcn_vpn" {
  cidr_block     = "${var.vcn_vpn_cidr_block}"
  dns_label      = "vcnvpn"
  compartment_id = "${var.compartment_ocid}"
  display_name   = "vcn_vpn"
}

resource "oci_core_internet_gateway" "internet_gateway" {
  compartment_id = "${var.compartment_ocid}"
  display_name   = "vcn_vpn_ig_01"
  vcn_id         = "${oci_core_virtual_network.vcn_vpn.id}"
}


resource "oci_core_route_table" "routing_table_default" {
  compartment_id = "${var.compartment_ocid}"
  vcn_id         = "${oci_core_virtual_network.vcn_vpn.id}"
  display_name   = "vcn_vpn_routing_table_default"

  route_rules {
    destination_type  = "CIDR_BLOCK"
    destination       = "0.0.0.0/0"
    network_entity_id = "${oci_core_internet_gateway.internet_gateway.id}"
  }

  route_rules {
    destination_type  = "CIDR_BLOCK"
    destination       = "${var.on_premises_cidr_block}"
    network_entity_id = "${oci_core_drg.drg_vpn_gateway.id}"
  }
}


resource "oci_core_drg" "drg_vpn_gateway" {
  compartment_id = "${var.compartment_ocid}"
  display_name   = "vcn_vpn_drg_01"
}

