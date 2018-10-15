output "drg_gateway" {
  value = ["${oci_core_drg.drg_vpn_gateway.display_name}",
  			"${oci_core_drg_attachment.drg_vpn_attachment.display_name}",
  			"${oci_core_drg_attachment.drg_vpn_attachment.drg_id}",
  			"${oci_core_cpe.default_cpe.ip_address}",
  			"${oci_core_cpe.default_cpe.display_name}",
  			"${oci_core_cpe.default_cpe.id}",
  			"${oci_core_ipsec.ip_sec_connection_default.display_name}",
  			"${oci_core_ipsec.ip_sec_connection_default.id}"
  ]
}

