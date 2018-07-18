variable "name" {}
variable "region" {}
variable "ip_network" {}
variable "vnic_set" {}

variable "servers" {
  type = "list"
}

variable "dns_name" {}

variable "cert_pem" {}
variable "ca_cert_pem" {}
