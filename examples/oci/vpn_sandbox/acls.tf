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
    destination       = "${var.vcn_vpn_on_premises_cidr_block}"
    network_entity_id = "${oci_core_drg.drg_vpn_gateway.id}"
  }
}

resource "oci_core_security_list" "security_list_default" {
  display_name   = "security_list_default"
  compartment_id = "${oci_core_virtual_network.vcn_vpn.compartment_id}"
  vcn_id         = "${oci_core_virtual_network.vcn_vpn.id}"

  egress_security_rules = [{
    protocol    = "all"
    destination = "0.0.0.0/0"
  }]

  ingress_security_rules = [{
    tcp_options {
      "max" = 22
      "min" = 22
    }

    protocol = "6"
    source   = "${var.cpe_ip_address}/32"
  },
    {
      protocol = "all"
      source   = "${var.vcn_vpn_on_premises_cidr_block}"
    },
    {
      // example of tcp rule
      tcp_options {
        "max" = 22
        "min" = 22
      }

      protocol = "6"
      source   = "192.168.255.255/32"
    },
    {
      // icmp protocol for troubleshooting
      icmp_options {
        "type" = 0
      }

      protocol = 1
      source   = "0.0.0.0/0"
    },
    {
      icmp_options {
        "type" = 3
        "code" = 4
      }

      protocol = 1
      source   = "0.0.0.0/0"
    },
    {
      icmp_options {
        "type" = 8
      }

      protocol = 1
      source   = "0.0.0.0/0"
    },
  ]
}
