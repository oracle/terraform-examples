// Copyright (c) 2018, 2019, Oracle and/or its affiliates. All rights reserved.

variable "public_ssh_key" {}

variable "server_count" {
  default = 1
}

variable "name" {}

variable "shape" {
  default = "oc3"
}

variable "image_list" {
  default = "/oracle/public/OL_7.2_UEKR4_x86_64"
}

variable "ip_network" {}
