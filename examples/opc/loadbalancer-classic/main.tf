provider "opc" {
  version         = "~> 1.2"
  user            = "${var.user}"
  password        = "${var.password}"
  identity_domain = "${var.domain}"
  endpoint        = "${var.endpoint}"
  lbaas_endpoint  = "${var.lbaas_endpoint}"
}

locals {
  ssh_user             = "opc"
  private_ssh_key_file = "./id_rsa"
  public_ssh_key_file  = "./id_rsa.pub"
  server_count         = 2
  dns_name             = "mywebapp.example.com"
}

module "server_network" {
  source = "./network"
  name   = "server-pool-network"
  cidr   = "192.168.100.0/24"
}

module "server_pool" {
  source         = "./server_pool"
  name           = "server"
  server_count   = "${local.server_count}"
  ip_network     = "${module.server_network.ipnetwork}"
  public_ssh_key = "${file(local.public_ssh_key_file)}"
}

module "webapp" {
  source               = "./webapp"
  servers              = "${module.server_pool.public_ip_addresses}"
  server_count         = "${local.server_count}"
  ssh_user             = "${local.ssh_user}"
  private_ssh_key_file = "${local.private_ssh_key_file}"
  public_ssh_key_file  = "${local.public_ssh_key_file}"
}

module "load_balancer" {
  source     = "./load_balancer"
  region     = "${var.region}"
  name       = "webapp-lb1"
  servers    = ["${formatlist("%s:%s", module.server_pool.private_ip_addresses, "7777")}"]
  ip_network = "/Compute-${var.domain}/${var.user}/${module.server_network.ipnetwork}"
  vnic_set   = "/Compute-${var.domain}/${var.user}/${module.server_pool.vnicset}"
  dns_name   = "${local.dns_name}"
}
