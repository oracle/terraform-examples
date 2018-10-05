resource "oci_core_security_list" "security_list_default" {
  display_name   = "security_list_default"
  compartment_id = "${oci_core_virtual_network.vcn_vpn.compartment_id}"
  vcn_id         = "${oci_core_virtual_network.vcn_vpn.id}"

  egress_security_rules = [{ protocol    = "all" destination = "0.0.0.0/0" }]
  ingress_security_rules = [
    { tcp_options { "max" = 22 "min" = 22 } protocol = "6" source   = "${var.cpe_ip_address}/32" },
    { protocol = "all" source   = "${var.on_premises_cidr_block}"},
// example of tcp rule
    { tcp_options { "max" = 22 "min" = 22 } protocol = "6" source   = "192.168.255.255/32" },
      // icmp protocol for troubleshooting
    { icmp_options { "type" = 0 } protocol = 1 source   = "0.0.0.0/0" },
    { icmp_options { "type" = 3 "code" = 4 } protocol = 1 source   = "0.0.0.0/0" },
    { icmp_options { "type" = 8 } protocol = 1 source   = "0.0.0.0/0" }
  ]
}

# Additional security list for local subnet
resource "oci_core_security_list" "local_sec_list_01" {
  display_name = "local_security_list_01"
  compartment_id = "${oci_core_virtual_network.vcn_vpn.compartment_id}"
  vcn_id         = "${oci_core_virtual_network.vcn_vpn.id}"
  egress_security_rules  = [
            { protocol = "all" destination = "0.0.0.0/0" },
  ]
  ingress_security_rules = [
            { protocol = "all" source = "${var.vcn_vpn_cidr_block}" },
            { protocol = 1 source = "0.0.0.0/0" stateless = true icmp_options { "type" = 3 "code" = 3} },
            { protocol = 1 source = "0.0.0.0/0" stateless = true icmp_options { "type" = 3 "code" = 4} },
            { protocol = 1 source = "0.0.0.0/0" stateless = true icmp_options { "type" = 0 "code" = 1} },
            { protocol = 1 source = "0.0.0.0/0" stateless = true icmp_options { "type" = 8 "code" = 1} },
  ]
}

# Additional security list for local subnet
resource "oci_core_security_list" "local_sec_list_02" {
  display_name = "local_security_list_02"
  compartment_id = "${oci_core_virtual_network.vcn_vpn.compartment_id}"
  vcn_id         = "${oci_core_virtual_network.vcn_vpn.id}"
  egress_security_rules  = [
            { protocol    = "all" destination = "0.0.0.0/0" },
  ]
  ingress_security_rules = [
            { protocol    = "all" source = "${var.vcn_vpn_cidr_block}" },
            { protocol = 1 source = "0.0.0.0/0" stateless = true icmp_options { "type" = 3 "code" = 3} },
            { protocol = 1 source = "0.0.0.0/0" stateless = true icmp_options { "type" = 3 "code" = 4} },
            { protocol = 1 source = "0.0.0.0/0" stateless = true icmp_options { "type" = 0 "code" = 1} },
            { protocol = 1 source = "0.0.0.0/0" stateless = true icmp_options { "type" = 8 "code" = 1} },
  ]
}

# Additional security list for local subnet
resource "oci_core_security_list" "local_sec_list_03" {
  display_name = "local_security_list_03}"
  compartment_id = "${oci_core_virtual_network.vcn_vpn.compartment_id}"
  vcn_id         = "${oci_core_virtual_network.vcn_vpn.id}"
  egress_security_rules  = [
            { protocol    = "all" destination = "0.0.0.0/0" },
  ]
  ingress_security_rules = [
            { protocol    = "all" source = "${var.vcn_vpn_cidr_block}" },
            { protocol = 1 source = "0.0.0.0/0" stateless = true icmp_options { "type" = 3 "code" = 3} },
            { protocol = 1 source = "0.0.0.0/0" stateless = true icmp_options { "type" = 3 "code" = 4} },
            { protocol = 1 source = "0.0.0.0/0" stateless = true icmp_options { "type" = 0 "code" = 1} },
            { protocol = 1 source = "0.0.0.0/0" stateless = true icmp_options { "type" = 8 "code" = 1} },
  ]
}
