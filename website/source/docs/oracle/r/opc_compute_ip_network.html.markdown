---
layout: "oracle"
page_title: "Oracle: opc_compute_ip_network"
sidebar_current: "docs-opc-resource-instance"
description: |-
  Creates and manages an IP Network in an OPC identity domain.
---

# opc\_compute\_ip\_network

The ``opc_compute_ip_network`` resource creates and manages an IP network in an OPC identity domain.

## Example Usage

```
resource "opc_compute_ip_network" "ipnetwork1" {
  name = "IPNetwork_1"
  description = "Example IP Network 1"
  ip_address_prefix = "192.168.2.0/24"
  ip_network_exchange = "${opc_compute_ip_network_exchange.test-ip-network-exchange.name}"
  tags = [ "tag1", "tag2" ]
}
```

## Argument Reference

The following arguments are supported:

* `name` - (Required) The name of the IP Network.

* `description` - (Optional) The description label for the IP Network.

  `ip_address_prefix` - (Required) The IP address range of the IP network in CIDR notation. e.g. `192.168.1.0/24`

  `ip_network_exchange` - (Optional) The name of the [opc_compute_ip_network_exchange](opc_compute_ip_network_exchange.html.markdown) to associate the IP Network with.

* `tags` - (Optional) List of tags that may be applied to the IP network.
