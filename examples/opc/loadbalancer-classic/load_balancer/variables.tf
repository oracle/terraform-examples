// Copyright (c) 2018, 2019, Oracle and/or its affiliates. All rights reserved.

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
variable "private_key_pem" {}
