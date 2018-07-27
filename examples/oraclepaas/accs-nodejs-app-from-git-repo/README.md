Example Node.js Application Deployment to Oracle Application Container Cloud Service
====================================================================================

This example demonstrates how to package and deploy a sample Node.js Language application to Oracle Application Container Cloud Service using Terraform

The sample application is based the example ["Create a Node.js Application from a Git Repository"](http://www.oracle.com/webfolder/technetwork/tutorials/obe/cloud/apaas/node/node-github-accs/node-github-accs.html)

The Terraform configuration:

- Launches the sample application instance on Application Container Cloud using locally defined `manifest.json` and the application source from the git repository URL

### Steps

This examples requires an existing Example application project within your own GitHub account. Follow the instructions to [Create a Git Repository](http://www.oracle.com/webfolder/technetwork/tutorials/obe/cloud/apaas/node/node-github-accs/node-github-accs.html) to prepare the application source code repository.

Create a local `terraform.tfvars` file with your environment specific credentials

```
domain="mydomain"
user="user@example.com"
password="Pa55_Word"
storage_endpoint="https://mydomain.storage.oraclecloud.com"

git_repository="https://github.com/<YourGitProject>/myNodeApp.git"
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
