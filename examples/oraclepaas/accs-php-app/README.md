Example PHP Application Deployment to Oracle Application Container Cloud Service
================================================================================

This example demonstrates how to package and deploy a sample PHP Language application to Oracle Application Container Cloud Service using Terraform

The sample application is based the example ["Deploy a PHP Application to Oracle Cloud
"](http://www.oracle.com/webfolder/technetwork/tutorials/obe/cloud/apaas/php/getting-started-php-accs/getting-started-php-accs.html)

### Steps


- Create a local `terraform.tfvars` file with your environment specific credentials

  ```
  domain="mydomain"
  user="user@example.com"
  password="Pa55_Word"
  storage_endpoint="https://mydomain.storage.oraclecloud.com"
  ```

To create the application instance

```
$ terraform init
$ terraform apply
```

To delete the application instance

```
$ terraform destroy
```
