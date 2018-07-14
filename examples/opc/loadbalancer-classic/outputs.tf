output "server_ip_address" {
  value = "${module.server_pool.public_ip_addresses}"
}

output "server_hostnames" {
  value = "${module.server_pool.hostnames}"
}


output "dns_instructions" {
  value = "Follow your DNS providers guidelines to create/update the CNAME record to redirect the domain `${local.dns_name}` to load balancers `canonical_host_name`"
}

output "canonical_host_name" {
  value = "${module.load_balancer.canonical_host_name}"
}
