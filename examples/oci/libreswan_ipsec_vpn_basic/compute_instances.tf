resource "oci_core_instance" "server01" {
  availability_domain = "${oci_core_subnet.subnet01.availability_domain}"
  compartment_id      = "${var.compartment_ocid}"
  display_name        = "server01"
  shape               = "${var.instance_shape}"

  source_details {
    source_id   = "${var.instance_image_ocid[var.region]}"
    source_type = "image"
  }

  create_vnic_details {
    subnet_id              = "${oci_core_subnet.subnet01.id}"
    hostname_label         = "server01"
    skip_source_dest_check = true
    assign_public_ip       = true
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
  availability_domain = "${oci_core_subnet.subnet02.availability_domain}"
  compartment_id      = "${var.compartment_ocid}"
  display_name        = "server02"
  shape               = "${var.instance_shape}"

  source_details {
    source_id   = "${var.instance_image_ocid[var.region]}"
    source_type = "image"
  }

  create_vnic_details {
    subnet_id              = "${oci_core_subnet.subnet02.id}"
    hostname_label         = "server02"
    skip_source_dest_check = true
    assign_public_ip       = true
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
  availability_domain = "${oci_core_subnet.subnet03.availability_domain}"
  compartment_id      = "${var.compartment_ocid}"
  display_name        = "server03"
  shape               = "${var.instance_shape}"

  source_details {
    source_id   = "${var.instance_image_ocid[var.region]}"
    source_type = "image"
  }

  create_vnic_details {
    subnet_id              = "${oci_core_subnet.subnet03.id}"
    hostname_label         = "server03"
    skip_source_dest_check = true
    assign_public_ip       = true
  }

  metadata {
    ssh_authorized_keys = "${file("./.ssh/id_rsa.pub")}"
    user_data           = "${base64encode(var.user-data-webservers)}"
  }

  lifecycle {
    ignore_changes = ["image", "metadata"]
  }
}
