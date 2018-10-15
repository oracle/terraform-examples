data "oci_core_ipsec_config" "vcn_vpn_ipsec_data" {
  ipsec_id = "${oci_core_ipsec.ip_sec_connection_default.id}"
}


output "vcn_vpn_ipsec_configuration" {
  value = ["${data.oci_core_ipsec_config.vcn_vpn_ipsec_data.tunnels}"
  ]
}
