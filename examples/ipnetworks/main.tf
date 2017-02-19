provider "opc" {
  user = "${var.user}"
  password = "${var.password}"
  identityDomain = "${var.domain}"
  endpoint = "${var.endpoint}"
}

resource "opc_compute_ssh_key" "ssh_key" {
  name = "ip-network-example-key"
  key = "${file(var.ssh_public_key)}"
  enabled = true
}

resource "opc_compute_ip_network" "ip-network-1" {
  name = "IPNetwork_1"
  description = "Example IP Network 1"
  ip_address_prefix = "192.168.2.0/24"
  ip_network_exchange = "${opc_compute_ip_network_exchange.test-ip-network-exchange.name}"
}

resource "opc_compute_ip_network" "ip-network-2" {
  name = "IPNetwork_2"
  description = "Example IP Network 2"
  ip_address_prefix = "192.168.3.0/24"
  ip_network_exchange = "${opc_compute_ip_network_exchange.test-ip-network-exchange.name}"
}

resource "opc_compute_ip_network" "ip-network-3" {
  name = "IPNetwork_3"
  description = "Example IP Network 3"
  ip_address_prefix = "192.168.2.0/24"
}

resource "opc_compute_ip_network_exchange" "test-ip-network-exchange" {
  name = "IPExchange"
  description = "IP Network Exchange"
}

resource "opc_compute_instance" "instance-1" {
	name = "Instance_1"
  hostname = "instance1"
	label = "Instance_1"
	shape = "oc3"
	imageList = "/oracle/public/OL_7.2_UEKR3_x86_64"
  networking = [ {
    index = 0
    ipnetwork = "${opc_compute_ip_network.ip-network-1.name}"
    ip = "192.168.2.16"
  }]
  sshKeys = [ "${opc_compute_ssh_key.ssh_key.name}" ]
}

resource "opc_compute_instance" "instance-2" {
	name = "Instance_2"
  hostname = "instance2"
	label = "Instance_2"
	shape = "oc3"
	imageList = "/oracle/public/OL_7.2_UEKR3_x86_64"
  networking = [ {
    index = 0
    ipnetwork = "${opc_compute_ip_network.ip-network-2.name}"
    ip = "192.168.3.11"
  }]
  sshKeys = [ "${opc_compute_ssh_key.ssh_key.name}" ]
}

resource "opc_compute_instance" "instance-3" {
	name = "Instance_3"
  hostname = "instance3"
	label = "Instance_3"
	shape = "oc3"
	imageList = "/oracle/public/OL_7.2_UEKR3_x86_64"
  networking = [ {
    index = 0
    nat = "ipreservation:${opc_compute_ip_reservation.reservation1.name}"
  },{
    index = 1
    ipnetwork = "${opc_compute_ip_network.ip-network-2.name}"
    ip = "192.168.3.16"
  }]
  sshKeys = [ "${opc_compute_ssh_key.ssh_key.name}" ]
}

resource "opc_compute_instance" "instance-4" {
	name = "Instance_4"
  hostname = "instance4"
	label = "Instance_4"
	shape = "oc3"
	imageList = "/oracle/public/OL_7.2_UEKR3_x86_64"
  networking = [ {
    index = 0
    nat = "ipreservation:${opc_compute_ip_reservation.reservation2.name}"
  },{
    index = 1
    ipnetwork = "${opc_compute_ip_network.ip-network-3.name}"
    ip = "192.168.2.16"
  }]
  sshKeys = [ "${opc_compute_ssh_key.ssh_key.name}" ]
}

resource "opc_compute_instance" "instance-5" {
	name = "Instance_5"
  hostname = "instance5"
	label = "Instance_5"
	shape = "oc3"
	imageList = "/oracle/public/OL_7.2_UEKR3_x86_64"
  networking = [ {
    index = 1
    ipnetwork = "${opc_compute_ip_network.ip-network-3.name}"
    ip = "192.168.2.18"
  }]
  sshKeys = [ "${opc_compute_ssh_key.ssh_key.name}" ]
}

resource "opc_compute_ip_reservation" "reservation1" {
	parentpool = "/oracle/public/ippool"
	permanent = true
}

resource "opc_compute_ip_association" "instance3_reservation1" {
	vcable = "${opc_compute_instance.instance-3.vcable}"
	parentpool = "ipreservation:${opc_compute_ip_reservation.reservation1.name}"
}

resource "opc_compute_ip_reservation" "reservation2" {
	parentpool = "/oracle/public/ippool"
	permanent = true
}

resource "opc_compute_ip_association" "instance4_reservation2" {
	vcable = "${opc_compute_instance.instance-4.vcable}"
	parentpool = "ipreservation:${opc_compute_ip_reservation.reservation2.name}"
}


module "instance3_install_ssh_keys" {
  source = "./modules/install_ssh_keys"
  trigger = "${opc_compute_instance.instance-3.id}"
  public_ip = "${opc_compute_ip_reservation.reservation1.ip}"
  ssh_user = "${var.ssh_user}"
  ssh_private_key = "${var.ssh_private_key}"
  ssh_public_key = "${var.ssh_public_key}"
}

module "instance4_install_ssh_keys" {
  source = "./modules/install_ssh_keys"
  trigger = "${opc_compute_instance.instance-4.id}"
  public_ip = "${opc_compute_ip_reservation.reservation2.ip}"
  ssh_user = "${var.ssh_user}"
  ssh_private_key = "${var.ssh_private_key}"
  ssh_public_key = "${var.ssh_public_key}"
}
