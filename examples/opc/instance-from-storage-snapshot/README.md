Create instance from a storage snapshot
=======================================

This example demonstrates creation of an instance with a persistent (block storage) bootable storage volume created from a storage volume snapshot

_See the [`instance-from-colocated-snapshot`](../instance-from-colocated-snapshot) example when using **colocated** snapshots._

The `opc_compute_storage_volume_snapshot` data source is used to reference an existing storage volume snapshot already created in the domain. Note that the name of the snapshot is the composition of the storage volume name and snapshot name.

```hcl
data "opc_compute_storage_volume_snapshot" "snapshot1" {
  name = "my-bootable-storage-volume/my-storage-volume-snapshot"
}
```

The new `opc_compute_storage_volume` resource is created from an existing snapshot by referencing the snapshot_id.  The snapshot size attribute can be used to correctly set the size of the new volume.

```hcl
resource "opc_compute_storage_volume" "volume1" {
  snapshot_id = "${data.opc_compute_storage_volume_snapshot.snapshot1.snapshot_id}"
  size        = "${data.opc_compute_storage_volume_snapshot.snapshot1.size}"
  ...
}
```

The `opc_compute_instance resource` is attached to the bootable storage volume and the `bootOrder` identifies the index of the specific storage attachement to boot from.

```hcl
resource "opc_compute_instance" "instance1" {
  ...
	storage {
		index = 1 volume = "${opc_compute_storage_volume.volume1.name}"
	}
	bootOrder = [ 1 ]
}
```
