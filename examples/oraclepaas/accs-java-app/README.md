Example Java Application Deployment to Oracle Application Container Cloud Service
=================================================================================

Deploys a Tomcat based Java application to the Java SE runtime on Oracle Application Container Cloud Service

This example is based on the ["Getting Started with Oracle Application Container Cloud"](http://www.oracle.com/webfolder/technetwork/tutorials/obe/cloud/apaas/acc-getting-started/welcome.html) tutorial

The Terraform configuration:

- Uploads the `employees-web-app.zip` sample application to an Object Storage Classic container
- Launches the sample application instance on Application Container Cloud

### Steps

- Download the `employees-web-app.zip` from and save it to the local folder http://www.oracle.com/webfolder/technetwork/tutorials/obe/cloud/apaas/acc-getting-started/files/employees-web-app.zip

Create a local `terraform.tfvars` file with your environment specific credentials

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
