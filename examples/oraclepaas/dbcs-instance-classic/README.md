Example Database Cloud Service Configuration
============================================

This example creates an Oracle Database Cloud Service Instance on Oracle Cloud Infrastructure Classic

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

To create the database instance

```
$ terraform init
$ terraform apply
```

To delete the database instance

```
$ terraform destroy
```
