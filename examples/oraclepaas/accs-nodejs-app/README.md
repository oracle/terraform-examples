Example Node.js Application Deployment to Oracle Application Container Cloud Service
====================================================================================

This example demonstrates how to package and deploy a sample Node.js Language application to Oracle Application Container Cloud Service using Terraform

The sample application is based the example ["Deploy a Node.js Application to Oracle Cloud"](http://www.oracle.com/webfolder/technetwork/tutorials/obe/cloud/apaas/node/getting-started-node-accs/getting-started-node-accs.html)

The Terraform configuration:

- Packages the Node.js sample application in the `./node-app` directory
- Uploads the packaged sample application to an Object Storage Classic container
- Launches the sample application instance on Application Container Cloud

### Steps

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
