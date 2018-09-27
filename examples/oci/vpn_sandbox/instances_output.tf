output "Server_Private_IP_Addresses" {
  value = ["${oci_core_instance.server01.private_ip}",
    "${oci_core_instance.server02.private_ip}",
    "${oci_core_instance.server03.private_ip}",
  ]
}
