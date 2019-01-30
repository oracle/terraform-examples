// Copyright (c) 2018, 2019, Oracle and/or its affiliates. All rights reserved.

variable "user" {}
variable "password" {}
variable "domain" {}
variable "endpoint" {}
variable "lbaas_endpoint" {}
variable "region" {}

variable "dns_name" {
  default = "mywebapp.example.com"
}
