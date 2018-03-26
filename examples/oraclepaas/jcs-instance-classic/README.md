Example Java Cloud Service Configuration
========================================

This example creates an Oracle Java Cloud Service Instance on Oracle Cloud Infrastructure Classic

Create a local `terraform.tfvars` with your account credentials

```
domain="idcs-5bb188b5460045f3943c57b783db7ffa"
user="user@example.com"
password="Pa55_Word"
```

Update the `main.tf` configuration to set the appropriate `ssh_public_key`  

```
ssh_public_key    = "ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQ..."
```

Ensure the `database` configuration is set correctly with the details of an existing database cloud service instance.

```hcl
database {
  name     = "my-terraformed-database"
  username = "sys"
  password = "Pa55_Word"
}
```

To create the java service instance

```
$ terraform init
$ terraform apply
```

To delete the java service instance

```
$ terraform destroy
```
