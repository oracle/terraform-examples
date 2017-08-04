Create instance from a storage snapshot
=======================================

This example demonstrates creation of an instance with a persistent (block storage) bootable storage volume created from a storage volume snapshot

The `opc_compute_storage_volume_snapshot` data source is used to reference an existing storage volume snapshot already created in the domain. Note that the name of the snapshot is the composition of the storage volume name and snapshot name.

```
name = "my-storage-volume/my-storage-volume-snapshot"
```

The new `opc_compute_storage_volume` resource is created from an existing snapshot by referencing the snapshot_id

```
snapshot_id = "${data.opc_compute_storage_volume_snapshot.my-snapshot.snapshot_id}"
size = "${data.opc_compute_storage_volume_snapshot.my-snapshot.size}"
```

The `opc_compute_instance resource` is attached to the bootable storage volume and the `bootOrder` identifies the index of the specific storage attachement to boot from.

```
storage {
	index = 1 volume = "${opc_compute_storage_volume.server-1-boot.name}"
}
bootOrder = [ 1 ]
```
