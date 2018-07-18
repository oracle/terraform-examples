
# main load balancer instance
resource "opc_lbaas_load_balancer" "lb1" {
  name        = "${var.name}"
  region      = "${var.region}"
  description = "My Example Load Balancer"

  scheme            = "INTERNET_FACING"
  ip_network        = "${var.ip_network}"
  permitted_methods = ["GET", "HEAD", "POST", "PUT"]
}


# Server Pool for backend Origin Servers
resource "opc_lbaas_server_pool" "serverpool1" {
  load_balancer = "${opc_lbaas_load_balancer.lb1.id}"

  name     = "serverpool1"
  servers  = ["${var.servers}"]
  vnic_set = "${var.vnic_set}"
}

# Round Robin Load Balancing Policy
resource "opc_lbaas_policy" "load_balancing_mechanism_policy" {
  load_balancer = "${opc_lbaas_load_balancer.lb1.id}"
  name          = "example_load_balancing_mechanism_policy"

  load_balancing_mechanism_policy {
    load_balancing_mechanism = "round_robin"
  }
}

# Listener to direct HTTP traffic for ${var.dns_name} to serverpool1
resource "opc_lbaas_listener" "listener1" {
  load_balancer = "${opc_lbaas_load_balancer.lb1.id}"
  name          = "listener1"
  port          = 80

  balancer_protocol = "HTTP"
  server_protocol   = "HTTP"
  server_pool       = "${opc_lbaas_server_pool.serverpool1.uri}"

  virtual_hosts = ["${var.dns_name}"]

  policies = [
    "${opc_lbaas_policy.load_balancing_mechanism_policy.uri}",
  ]
}

# Trusted Certificate for ${var.dns_name}
resource "opc_lbaas_certificate" "trusted" {
  name = "trusted-cert1"
  type = "TRUSTED"
  certificate_body = "${var.cert_pem}"
  certificate_chain = "${var.ca_cert_pem}"
}

# Trusted Certificate policy
resource "opc_lbaas_policy" "trusted_certificate_policy" {
  load_balancer = "${opc_lbaas_load_balancer.lb1.id}"
  name          = "example_trusted_certificate_policy"

  trusted_certificate_policy {
    trusted_certificate = "${opc_lbaas_certificate.trusted.uri}"
  }
}

# Listener to direct HTTPS traffic for ${var.dns_name} to serverpool1
resource "opc_lbaas_listener" "listener2" {
  load_balancer = "${opc_lbaas_load_balancer.lb1.id}"
  name          = "listener2"
  port          = 443

  balancer_protocol = "HTTPS"
  server_protocol   = "HTTP"
  server_pool       = "${opc_lbaas_server_pool.serverpool1.uri}"

  virtual_hosts = ["${var.dns_name}"]

  policies = [
    "${opc_lbaas_policy.load_balancing_mechanism_policy.uri}",
    "${opc_lbaas_policy.trusted_certificate_policy.uri}"
  ]
}
