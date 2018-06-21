Example MySQL Cloud PaaS Service Configuration on Oracle Cloud Infrastructure
=============================================================================

This example creates an Oracle MySQL Cloud Service instance on Oracle Cloud Infrastructure Classic.

Before being able to create an instance that is configured for backups to OCI Object Storage you must first follow the steps to create an Object Storage Bucket for storing the Backups.

- Create a Bucket in OCI Object Storage, e.g. `PaaSBucket`
- Create a Swift Password for user (e.g. `api.user`)

See [Prerequisites for Oracle Platform Services on Oracle Cloud Infrastructure](https://docs.us-phoenix-1.oraclecloud.com/Content/General/Reference/PaaSprereqs.htm) from more details.

Create a local `terraform.tfvars` with your account credentials

```
# Oracle PaaS Cloud Account
identity_domain="mydomain"
service_id="590595900"
identity_service_id="idcs-5bb188b5460045f3943c57b783db7ffa"
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
object_storage_bucket="PaaSBucket"
object_storage_namespace="mydomain"
object_storage_user="api.user"
swift_password="2imuh5re6+fx;ulJ60[Z"
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
