Example Ruby Application Deployment to Oracle Application Container Cloud Service
=================================================================================

This example demonstrates how to package and deploy a sample Ruby Language application to Oracle Application Container Cloud Service using Terraform

The sample application is based the example ["Deploy a Ruby Application to Oracle Cloud
"](http://www.oracle.com/webfolder/technetwork/tutorials/obe/cloud/apaas/ruby/ruby-getting-started/ruby-getting-started.html)

The Terraform configuration:

- Uploads the sample `app.zip` Ruby application to the Object Storage Classic container
- Launches the sample application instance on Application Container Cloud

### Steps

- Download the example Ruby application `app.zip` from  http://www.oracle.com/webfolder/technetwork/tutorials/obe/cloud/apaas/ruby/ruby-getting-started/files/app.zip and place it in the local directory. The file contains the Ruby source code and `manifest.json` metadata file needed to launch a Ruby application.

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
