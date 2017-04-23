Migration
=========

Migrating configuartions originally created for the [terraform-oracle-opc](https://github.com/oracle/terraform-provider-compute) provider plugin to the built-in Oracle Public Cloud `opc` provider consists of two key tasks:

1.	Migrating existing configuration files to the latest provider syntax
2.	Migrating any existing deployed environment state to the new built-in provider

Migrating .tf configuration files
---------------------------------

Migration of existing terraform configurations from the provider plugin to the new built-in provider is simple. A few minor syntax changes are required:

### Provider changes

The `identityDomain` attribute in the `opc` `provider` block is now called `identity_domain`

```
provider "opc" {
  user = "${var.user}"
  password = "${var.password}"
  identity_domain = "${var.domain}"
  endpoint = "${var.endpoint}"
}
```

You will also need to remove the `opc` entry for the provider plugin from your `~/.terraformrc` or `%APPDATA%\terraform.rc` configuration file, and ensure the `terraform-provier-opc` executable is not in your local environment PATH.

### Resource changes

Several resource attribute names have been updated from camelCase to under_score format for consistent syntax styling.

| Resource                     | Old Attribute name | New Attribute name    |
|:-----------------------------|:-------------------|:----------------------|
| `opc_compute_instance`       | `imageList`        | `image_list`          |
| `opc_compute_instance`       | `sshKeys`          | `ssh_keys`            |
| `opc_compute_instance`       | `attributes`       | `instance_attributes` |
| `opc_compute_ip_association` | `parentpool`       | `parent_pool`         |
| `opc_compute_ip_reservation` | `parentpool`       | `parent_pool`         |

#### Storage Volume resource changes

The storage `size` no longer uses the `g` suffix, size is always declared in gigabytes.

The `bootableImage` and `bootableImageVersion` attributes have been replaced with a `bootable` block definiton within the resource.

```
resource "opc_compute_storage_volume" "volume1" {
    size = "12"
    description = "Example bootable storage volume"
    name = "boot-from-storage-example"
    bootable {
        image_list = "/oracle/public/OL_6.8_UEKR3_x86_64"
        image_list_entry = 3
    }
}
```

#### Security Resource name change

The name of the `opc_compute_security_rule` resource used to define [Security Rules on the Shared Network](https://docs.oracle.com/cloud/latest/stcomputecs/STCSA/api-SecRules.html) has been changed to `opc_compute_sec_rule`. This resource name change is to provide naming consistency with the Oracle Compute Cloud API, the `opc_compute_security_rule` resource now defines an [IP Network Security Rule](https://docs.oracle.com/cloud/latest/stcomputecs/STCSA/api-SecurityRules.html).

Migrating existing deployment state
-----------------------------------

Environments provisioned with original opc provider plugin will need reprovisioned or imported to the new configuration.

### Quick and dirty (Destroy and Rebuild)

CAUTION: THIS APPROACH WILL REMOVE ALL EXISTING RESOURCES

1.	`terraform destroy`
2.	update the `.tf` configurations file to the latest provider syntax
3.	`terraform apply`

#### Safest (Import)

This approach can be used to migrate an existing deployed environment into to the new opc terraform provider.

1.	backup your original configuration
2.	update the `.tf` configurations file to the latest provider syntax
3.	run `terraform refresh` to update the resources.
4.	any resources that could not be refreshed by the new provider will have been removed terraform.tfstate, run `terraform plan` to see which resources are missing.
5.	use `terraform import` to import the configuration for each misssing resource
6.	check all imports are complete and the configuration matches the deployed resource state using `terraform plan`

The required IDs for the existing resource may be found in the original `terraform.tfstate` file, in the Oracle Compute Cloud UI Console, or using the Oracle Compute CLI tool. Example imports:

```
terraform import opc_compute_ssh_key.sshkey1 example-sshkey1
terraform import opc_compute_ip_reservation.ipreservation1 502189c5-4fe0-455f-bee1-0d40083d737c
terraform import opc_compute_ip_association.instance1-ipreservation 0f7de745-affc-4ea0-95c6-7740af246ac9
terraform import opc_compute_instance.instance1 example-instance1/a38f7e99-c182-45b9-b457-a514af3ab335
```

If all the resources have been refreshed and imported successfully then running `terraform plan` should indicate the configuration is up to date.

```
Refreshing Terraform state in-memory prior to plan...
The refreshed state will be used to calculate this plan, but will not be
persisted to local or remote state storage.

opc_compute_ip_reservation.ipreservation1: Refreshing state... (ID: 502189c5-4fe0-455f-bee1-0d40083d737c)
opc_compute_ssh_key.sshkey1: Refreshing state... (ID: example-sshkey1)
opc_compute_instance.instance1: Refreshing state... (ID: a38f7e99-c182-45b9-b457-a514af3ab335)
opc_compute_ip_association.instance1-ipreservation: Refreshing state... (ID: 0f7de745-affc-4ea0-95c6-7740af246ac9)
No changes. Infrastructure is up-to-date.

This means that Terraform did not detect any differences between your
configuration and real physical resources that exist. As a result, Terraform
doesn't need to do anything.
```
