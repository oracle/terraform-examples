Database Service Instance on OCI with Backup Configuration
==========================================================

Refer to [data-service-instance-oci](../data-service-instance-oci) Example for general setup

This configuration creates a new database instance configured for backups.

Before being able to create an instance that is configured with backups you must first follow the sets to Create an Object Storage Bucket for storing the Backup
(https://docs.us-phoenix-1.oraclecloud.com/Content/General/Reference/PaaSprereqs.htm?Highlight=paas)


Create a Bucket in OCI Object Storage, e.g. `PaaSBucket`

Create a Swift Password for user (e.g. `api.user`)

Add the Object Storage User and password in the `terraform.tfvars`

```
object_storage_user="api.user"
swift_password="}qhShU36iQ_5zM$}$yKi"
```

Also add the variable values for the deployment tenancy, availability_domain and subnet_ocid in the `terraform.tfvars`

```
tenancy="gse00014447"
availability_domain="orxe:US-ASHBURN-AD-2"
subnet_ocid="ocid1.subnet.oc1.iad.aaaaaaaay7lkm4wvcedvrfm4tmuqvrla7aagv4voaufo3lbl4s7bzfsfe2ua"
```


Notes
-----

You cannot use an OCI Classic Storage Container for OCI instance backups. Trying to use a Classic Storage Container will result in the error:

```
400: Unable to create Oracle Storage Cloud Service container [https://idcs-ba7969655dcb4bada92b0d77670ba7bf.storage.oraclecloud.com/v1/Storage-idcs-ba7969655dcb4bada92b0d77670ba7bf/my-terraformed-database-oci-with-backup] with BMC service.
```
