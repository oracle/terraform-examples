resource "opc_compute_storage_volume" "volume1" {
  size                 = "12g"
  description          = "Example bootable storage volume"
  name                 = "boot-from-storage-example"
  bootableImage        = "/oracle/public/OL_6.8_UEKR3_x86_64"
  bootableImageVersion = 3
}

resource "opc_compute_instance" "instance1" {
  name  = "boot-from-storage-instance1"
  label = "Example instance with bootable storage"
  shape = "oc3"

  storage = [{
    index  = 1
    volume = "${opc_compute_storage_volume.volume1.name}"
  }]

  bootOrder = [1]
}
