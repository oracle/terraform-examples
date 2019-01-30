// Copyright (c) 2018, 2019, Oracle and/or its affiliates. All rights reserved.

resource "opc_compute_ip_network" "ipnetwork" {
  name              = "${var.name}"
  ip_address_prefix = "${var.cidr}"
}
