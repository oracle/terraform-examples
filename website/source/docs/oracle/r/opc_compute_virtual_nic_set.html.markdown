---
layout: "oracle"
page_title: "Oracle: opc_compute_virtual_nic_set"
sidebar_current: "docs-opc-resource-instance"
description: |-
  Creates and manages a Virtual NIC Set in an OPC identity domain.
---

# opc\_compute\_virtual\_nic\_set

The ``opc_compute_virtual_nic_set`` resource creates and manages a Virtual NIC Set in an OPC identity domain.

## Example Usage

```
resource "opc_compute_virtual_nic_set" "vnicset1" {
  name = "test-vnic-set"
  description = "my virtual nic set"
  virtual_nics = [ "${opc_compute_instance.test_instance.name}/${opc_compute_instance.test_instance.opcId}/eth1" ]
  tags = [ "tag1", "tag2", "tag3" ]
}
```

## Argument Reference

The following arguments are supported:

* `name` - (Required) The name of the IP Network.

* `description` - (Optional) The description label for the IP Network.

  `virtual_nics` = (Required) A set of one of more Virtual NICs associated with this Virtual NIC set

* `tags` - (Optional) List of tags that may be applied to the IP network.
