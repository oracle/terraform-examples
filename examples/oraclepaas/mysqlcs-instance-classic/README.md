Example MySQL Cloud PaaS Service Configuration on Oracle Cloud Infrastructure Classic
=====================================================================================

This example creates an Oracle MySQL Cloud Service instance on Oracle Cloud Infrastructure Classic.

- creates the IP Network the instance will be connected to
- creates the MySQL Cloud Service instance
- creates an Access Rule to allow access to the Database
- creates an Access Rule to allow access to the EM Console

Create a local `terraform.tfvars` with your account credentials, e.g.

```
identity_domain_name="mydomain"
service_id="590595900"
identity_service_id="idcs-5bb188b5460045f3943c57b783db7ffa"
user="user@example.com"
password="Pa55_Word"
endpoint="https://compute.uscom-central-1.oraclecloud.com/"
region="uscom-central-1"

source_ip="59.59.59.59"
```

Set the `source_ip` to the ip address, or list of ip address and cidr ranges to allow access the the MySQL instance and EM console.

To create the MySQL Cloud Service database instance

```
$ terraform init
$ terraform apply
```

To delete the database instance

```
$ terraform destroy
```
