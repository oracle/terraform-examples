resource "oci_core_instance" "server01" {
  availability_domain = "${oci_core_subnet.sub01be.availability_domain}"
  compartment_id      = "${var.compartment_ocid}"
  display_name        = "server01"
  shape               = "${var.instance_shape}"

  source_details {
    source_id   = "${var.instance_image_ocid[ var.region ]}"
    source_type = "image"
  }

  create_vnic_details {
    subnet_id              = "${oci_core_subnet.sub01be.id}"
    hostname_label         = "server01"
    skip_source_dest_check = true
    assign_public_ip       = false
  }

  metadata {
    ssh_authorized_keys = "${file("./.ssh/id_rsa.pub")}"
    user_data           = "${base64encode(var.user-data-webservers)}"
  }

  lifecycle {
    ignore_changes = ["image", "metadata"]
  }
}

resource "oci_core_instance" "server02" {
  availability_domain = "${oci_core_subnet.sub02be.availability_domain}"
  compartment_id      = "${var.compartment_ocid}"
  display_name        = "server02"
  shape               = "${var.instance_shape}"

  source_details {
    source_id   = "${var.instance_image_ocid[ var.region ]}"
    source_type = "image"
  }

  create_vnic_details {
    subnet_id              = "${oci_core_subnet.sub02be.id}"
    hostname_label         = "server02"
    skip_source_dest_check = true
    assign_public_ip       = false
  }

  metadata {
    ssh_authorized_keys = "${file("./.ssh/id_rsa.pub")}"
    user_data           = "${base64encode(var.user-data-webservers)}"
  }

  lifecycle {
    ignore_changes = ["image", "metadata"]
  }
}

resource "oci_core_instance" "server03" {
  availability_domain = "${oci_core_subnet.sub03be.availability_domain}"
  compartment_id      = "${var.compartment_ocid}"
  display_name        = "server03"
  shape               = "${var.instance_shape}"

  source_details {
    source_id   = "${var.instance_image_ocid[ var.region ]}"
    source_type = "image"
  }

  create_vnic_details {
    subnet_id              = "${oci_core_subnet.sub03be.id}"
    hostname_label         = "server03"
    skip_source_dest_check = true
    assign_public_ip       = false
  }

  metadata {
    ssh_authorized_keys = "${file("./.ssh/id_rsa.pub")}"
    user_data           = "${base64encode(var.user-data-webservers)}"
  }

  lifecycle {
    ignore_changes = ["image", "metadata"]
  }
}
