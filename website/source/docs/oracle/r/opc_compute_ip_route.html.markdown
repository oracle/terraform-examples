---
layout: "oracle"
page_title: "Oracle: opc_compute_ip_route"
sidebar_current: "docs-opc-resource-instance"
description: |-
  Creates and manages an Route in an OPC identity domain.
---

# opc\_compute\_ip\_route

The ``opc_compute_ip_route`` resource creates and manages a Route in an OPC identity domain.

## Example Usage

```
resource "opc_compute_ip_route" "iproute1" {
  name = "test-route"
  description = "my updated test route"
  admin_distance = 1
  ip_address_prefix = "192.168.2.0/16"
  next_hop_virtual_nic_set = "${opc_compute_virtual_nic_set.test-vnic-set.name}"
  tags = [ "tag1", "tag2", "tag3" ]
}
```

## Argument Reference

The following arguments are supported:

* `name` - (Required) The name of the Route.

* `description` - (Optional) The description label for the Route.

  `admin_distance` - (Optional) Route's administrative distance `0`, `1`, or `2`. If not set the default value is `0`.

  `ip_address_prefix` - (Required) The IP address prefix, in CIDR notation, of the target network to route traffic.

  `next_hop_virtual_nic_set` - (Required) The name of the [opc_compute_virtual_nic_set](opc_compute_virtual_nic_set.html.markdown) to route matching packets to.

* `tags` - (Optional) List of tags that may be applied to the IP route.
