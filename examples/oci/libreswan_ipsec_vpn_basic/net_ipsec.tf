resource "oci_core_drg_attachment" "drg_vpn_attachment" {
  drg_id       = "${oci_core_drg.drg_vpn_gateway.id}"
  vcn_id       = "${oci_core_virtual_network.vcn_vpn.id}"
  display_name = "vcn_vpn_drg_01_att"
}

resource "oci_core_cpe" "default_cpe" {
  compartment_id = "${var.compartment_ocid}"
  ip_address     = "${var.cpe_ip_address}"
  display_name = "vcn_vpn_cpe_01"
}

resource "oci_core_ipsec" "ip_sec_connection_default" {
  compartment_id = "${var.compartment_ocid}"
  cpe_id         = "${oci_core_cpe.default_cpe.id}"
  drg_id         = "${oci_core_drg.drg_vpn_gateway.id}"
  static_routes  = "${var.ipsec_static_routes}"

  display_name = "VCN VPN default IP-SEC connection"

  timeouts {
    create = "15m"
    delete = "15m"
  }
}
