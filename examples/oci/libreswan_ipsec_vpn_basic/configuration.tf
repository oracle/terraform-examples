////// environment setup ///////
variable "instance_shape" {
  default = "VM.Standard2.1"
}

variable "instance_image_ocid" {
  type = "map"

  default = {
    // See https://docs.cloud.oracle.com/iaas/images/oraclelinux-7x/
    // Oracle-provided image "Oracle-Linux-7.5-2018.08.14-0"
    eu-frankfurt-1 = "ocid1.image.oc1.eu-frankfurt-1.aaaaaaaakzrywmh7kwt7ugj5xqi5r4a7xoxsrxtc7nlsdyhmhqyp7ntobjwq"
    us-ashburn-1 = "ocid1.image.oc1.iad.aaaaaaaa2tq67tvbeavcmioghquci6p3pvqwbneq3vfy7fe7m7geiga4cnxa"
    uk-london-1  = "ocid1.image.oc1.uk-london-1.aaaaaaaalsdgd47nl5tgb55sihdpqmqu2sbvvccjs6tmbkr4nx2pq5gkn63a"
    us-phoenix-1 = "ocid1.image.oc1.phx.aaaaaaaasez4lk2lucxcm52nslj5nhkvbvjtfies4yopwoy4b3vysg5iwjra"
  }
}

data "oci_identity_availability_domains" "ads" {
  compartment_id = "${var.compartment_ocid}"
}

//VCN local CIDR block
variable "vcn_vpn_cidr_block" {
  description = "VCN IP range"
  default     = "172.31.0.0/16"
}

//VCN local subnets
variable "vcn_vpn_subnets_cidr_blocks" {
  description = "VCN subnets"
  default     = ["172.31.0.0/24", "172.31.1.0/24", "172.31.2.0/24"]
}

variable "cpe_ip_address" {
  //update to your external IP ADDRESS
  default = "1.2.3.4"
}

variable "ipsec_static_routes" {
  // ipsec encryption domain
  default = ["0.0.0.0/0"]
}

//On premises LAN IP range
variable "on_premises_cidr_block" {
  description = "On premises IP range"
  default = "10.20.0.0/16"
}
