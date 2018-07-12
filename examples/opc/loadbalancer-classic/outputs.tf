output "servers" {
  value = "${module.server_pool.public_ip_addresses}"
}

output "dns_instructions" {
  value = "Follow your DNS providers guidelines to create/update the CNAME record to redirect\n${local.dns_name} to ${module.load_balancer.canonical_host_name}"
}
