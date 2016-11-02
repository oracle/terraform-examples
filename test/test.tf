resource "opc_compute_instance" "test_instance" {
	name = "test"
	label = "test"
	shape = "oc3"
	imageList = "/oracle/public/oel_6.4_2GB_v1"
	storage = [{
		index = 1
		volume = "${opc_compute_storage_volume.test_volume.name}"
	},
	{
		index = 2
		volume = "${opc_compute_storage_volume.test_volume2.name}"
	}]
}

resource "opc_compute_storage_volume" "test_volume" {
	size = "3g"
	description = "My volume"
	name = "test_volume_b"
	tags = ["foo", "bar", "baz"]
}

resource "opc_compute_storage_volume" "test_volume2" {
	size = "3g"
	description = "My other volume"
	name = "test_volume_c"
	tags = ["xyzzy", "quux"]
}

resource "opc_compute_ip_reservation" "reservation1" {
        parentpool = "/oracle/public/ippool"
        permanent = true
	tags = []
}

resource "opc_compute_ip_association" "instance1_reservation1" {
	vcable = "${opc_compute_instance.test_instance.vcable}"
	parentpool = "ipreservation:${opc_compute_ip_reservation.reservation1.name}"
}

resource "opc_compute_security_list" "sec_list1" {
	name = "sec-list-1"
        policy = "PERMIT"
        outbound_cidr_policy = "DENY"
}

resource "opc_compute_security_association" "test_instance__sec_list_1" {
	vcable = "${opc_compute_instance.test_instance.vcable}"
	seclist = "${opc_compute_security_list.sec_list1.name}"
}
