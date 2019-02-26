

// Copyright (c) 2018, 2019, Oracle and/or its affiliates. All rights reserved.
data "oci_identity_availability_domains" "ADs" {
  compartment_id = "${var.tenancy_ocid}"
}
###### BRIDGE INSTANCE #########
# Get Bridge instance object from instance pool
data "oci_core_instance" "bridge_instance" {

    instance_id = "${lookup(data.oci_core_instance_pool_instances.bridge_instance_pool_instances.instances[0],"id")}"
}

data "oci_core_instance_pool_instances" "bridge_instance_pool_instances" {

    compartment_id = "${var.compartment_ocid}"
    instance_pool_id = "${oci_core_instance_pool.bridge_instance_pool.id}"
}

# Gets a list of private IPs on the second VNIC

resource "oci_core_private_ip" "BridgeInstancePrivateIP" {
  vnic_id      = "${data.oci_core_vnic.BridgeInstanceVnic1.id}"
  display_name = "BridgeInstancePrivateIP"
}
data "oci_core_private_ips" "BridgeInstancePrivateIP2" {
  vnic_id = "${data.oci_core_vnic.BridgeInstanceVnic2.id}"
}


# Get the OCID of the primary VNIC
data "oci_core_vnic" "BridgeInstanceVnic1" {
   vnic_id = "${lookup(data.oci_core_vnic_attachments.BridgeInstanceVnics.vnic_attachments[0],"vnic_id")}"
}

# Get the OCID of the secondary VNIC
data "oci_core_vnic" "BridgeInstanceVnic2" {
   depends_on = ["oci_core_instance_pool.bridge_instance_pool"]
   vnic_id = "${lookup(data.oci_core_vnic_attachments.BridgeInstanceVnics.vnic_attachments[1],"vnic_id")}"
}

data "oci_core_vnic_attachments" "BridgeInstanceVnics" {
  compartment_id      = "${var.compartment_ocid}"
  availability_domain = "${lookup(data.oci_identity_availability_domains.ADs.availability_domains[var.AD - 1],"name")}"
  instance_id         = "${data.oci_core_instance.bridge_instance.id}"
} 


