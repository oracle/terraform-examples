Database Service Instance on OCI with Backup Configuration
==========================================================

This configuration creates a new database instance configured for backups.

To deploy the Database Cloud Service Instances on OCI instances you must first create a VCN and Subnet.  This can be created in the UI or using the `oci` Terraform provider. This example includes the VCN configuration.

Before being able to create an instance that is configured with backups you must first follow the steps to create an Object Storage Bucket for storing the Backups

- Create a Bucket in OCI Object Storage, e.g. `PaaSBucket`
- Create a Swift Password for user (e.g. `api.user`)

See [Prerequisites for Oracle Platform Services on Oracle Cloud Infrastructure](https://docs.us-phoenix-1.oraclecloud.com/Content/General/Reference/PaaSprereqs.htm) from more details.

Create a local `terraform.tfvars` with your account credentials

```
# Oracle Cloud Account
domain="idcs-5bb188b5460045f3943c57b783db7ffb"
user="user@example.com"
password="Pa55_Word"

# Oracle Cloud Infrastructure Tenancy
tenancy_ocid="ocid1.tenancy.oc1..aaaaaaaaw6ti6w2rgk2q3gwahgzha43gi4y4kxrrkkfptq3wloxx3aclb2zb"
region="us-ashburn-1"
compartment_ocid="ocid1.compartment.oc1..aaaaaaaaiqjpmzjood5c5357anrtwk2jfpm7rouzfnit7n4b5lwkl6w6gkab"
user_ocid="ocid1.user.oc1..aaaaaaaawkc2uzswdifko4v4foytsrtrtqqlonavyora6sxwmbuski422xfb"
private_key_path="/home/vagrant/.oci/oci_api_key.pem"
fingerprint="ae:ea:b2:1a:7b:d3:d2:75:8d:50:4e:00:ca:59:17:ff"

# Object Storage for PaaS
object_storage_user="api.user"
swift_password="2imuh5re6+fx;ulJ60[Z"
object_storage_bucket="PaaSBucket"
```

Ensure the shape is a valid OCI shape, and that the tenancy shape is available within the service limits

```hcl
shape = "VM.Standard2.2"
```
For OCI instances the `usable_storage` must be a minimum of 50Gb

```hcl
database_configuration {
  ...
  usable_storage = 50
}
```

To create the database instance

```
$ terraform init
$ terraform apply
```

To delete the database instance

```
$ terraform destroy
```


Notes
-----

You cannot use an OCI Classic Storage Container for OCI instance backups. Trying to use a Classic Storage Container will result in the error:

```
400: Unable to create Oracle Storage Cloud Service container [https://idcs-ba7969655dcb4bada92b0d77670ba7bf.storage.oraclecloud.com/v1/Storage-idcs-ba7969655dcb4bada92b0d77670ba7bf/my-terraformed-database-oci-with-backup] with BMC service.
```
