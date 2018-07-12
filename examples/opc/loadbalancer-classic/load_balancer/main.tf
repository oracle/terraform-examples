
resource "opc_lbaas_load_balancer" "lb1" {
  name        = "${var.name}"
  region      = "${var.region}"
  description = "My Example Load Balancer"

  scheme            = "INTERNET_FACING"
  ip_network        = "${var.ip_network}"
  permitted_methods = ["GET", "HEAD", "POST", "PUT"]
}

resource "opc_lbaas_server_pool" "serverpool1" {
  load_balancer = "${opc_lbaas_load_balancer.lb1.id}"

  name     = "serverpool1"
  servers  = ["${var.servers}"]
  vnic_set = "${var.vnic_set}"
}

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

resource "opc_lbaas_policy" "load_balancing_mechanism_policy" {
  load_balancer = "${opc_lbaas_load_balancer.lb1.id}"
  name          = "example_load_balancing_mechanism_policy"

  load_balancing_mechanism_policy {
    load_balancing_mechanism = "round_robin"
  }
}
