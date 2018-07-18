
output "ipnetwork" {
  value = "${opc_compute_ip_network.ipnetwork.name}"
}

output "cidr" {
  value = "${opc_compute_ip_network.ipnetwork.ip_address_prefix}"
}
