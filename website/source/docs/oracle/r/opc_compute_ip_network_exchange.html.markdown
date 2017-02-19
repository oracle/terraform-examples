---
layout: "oracle"
page_title: "Oracle: opc_compute_ip_network_exchange"
sidebar_current: "docs-opc-resource-instance"
description: |-
  Creates and manages an IP Network in an OPC identity domain.
---

# opc\_compute\_ip\_network_exchange

The ``opc_compute_ip_network_exchange`` resource creates and manages an IP networkexchange in an OPC identity domain.

## Example Usage

```
resource "opc_compute_ip_network_exchange" "ipnetworkexchange1" {
  name = "test-ip-network-exchange"
  description = "my ip network exchange"
  tags = [ "tag1", "tag2", "tag3" ]
}
```

## Argument Reference

The following arguments are supported:

* `name` - (Required) The name of the IP Network.

* `description` - (Optional) The description label for the IP Network.

* `tags` - (Optional) List of tags that may be applied to the IP network exchange.
