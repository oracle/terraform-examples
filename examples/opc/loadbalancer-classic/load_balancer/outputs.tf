// Copyright (c) 2018, 2019, Oracle and/or its affiliates. All rights reserved.

output "canonical_host_name" {
  value = "${opc_lbaas_load_balancer.lb1.canonical_host_name}"
}
