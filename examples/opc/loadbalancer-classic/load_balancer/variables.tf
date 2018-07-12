variable "name" {}
variable "region" {}
variable "ip_network" {}
variable "vnic_set" {}

variable "servers" {
  type = "list"
}

variable "dns_name" {}
