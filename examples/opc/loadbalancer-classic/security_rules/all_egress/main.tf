// Copyright (c) 2018, 2019, Oracle and/or its affiliates. All rights reserved.

variable "name" {}
variable "acl" {}

resource "opc_compute_security_rule" "egress" {
  name               = "${var.name}-all-egress"
  flow_direction     = "egress"
  acl                = "${var.acl}"
  security_protocols = ["${opc_compute_security_protocol.all.name}"]
}

resource "opc_compute_security_protocol" "all" {
  name        = "${var.name}-all"
  ip_protocol = "all"
}
