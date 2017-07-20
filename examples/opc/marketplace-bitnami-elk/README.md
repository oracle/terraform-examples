Provisioning an ELK stack instance using Bitnami ELK for Oracle Cloud
=====================================================================

This example provides a self contained Terraform configuration to launch and configure a single ELK stack instance on Oracle Compute Cloud using the Bitnami ELK For Oracle Cloud image from the [Oracle Cloud Marketplace](https://cloudmarketplace.oracle.com/marketplace/product/compute).

Prerequisites
-------------

### Enable the Bitnami ELK image

The Bitnami ELK image must first be enabled in your domain. Go the [ELK on OL 6.7](https://cloudmarketplace.oracle.com/marketplace/en_US/listing/12324385) Oracle Cloud Marketplace listing and select **Get App**. Select the target Compute domain, accept the Terms and Conditions, and select **Install**. When you get the *Application Successfully Installed* confirmation proceed with the steps below.

### Create the local Terraform variables file (Optional)

Create a local file called `terraform.tfvars` which sets the required attributes for provider. If these variables are not set then Terraform will prompt for the values on each run.

```
domain = "mydomain"
endpoint = "https://api-z27.compute.us6.oraclecloud.com/"
user = "user@example.com"
password = "Pa55W0rd"
```

### Generate SSH Keys

To generate ssh keys used to configure and access the instance run:

```
$ ssh-keygen -f ./id_rsa -N '' -q
```

or set the `ssh_public_key_file` and `ssh_private_key_file` variables to the location of desired the ssh key files in the `terraform.tfvars`

Create the ELK Instance
-----------------------

Test the Terraform configuration and review provisioning plan

```
$ terraform plan
```

Apply the configuration to create the ELK stack instance run

```
$ terraform apply
```

Remember to run `terraform destroy` when you are finished with the instance to clean up all resources

Configuration Overview
----------------------

This Terraform configuration creates the following resources:

-	a `bitnami-elk-sshkey` **SSH Key** that is associated to the instance to enabled SSH access
-	a `bitnami-elk-ip` **IP Reservation** for public IP access to the instance
-	a `For-ELK-access` **Security List** and associated `Allow-ELK-http-access` and `Allow-ELK-http-access` **Security Rules** to enable HTTP and SSH access to the instance from the Public Internet
-	a `bitnami-elk` **Instance** launched from the Bitnami ELK image

Terraform provisioners are used to configure the instance. The sample configuration used is based on the [Getting Started With Bitnami ELK Stack](https://docs.bitnami.com/oracle/apps/elk/) example.

When the Terraform provisioning is complete the output log will show the initial generated password for the elk web login (default user is `user`). The ELK web URL and SSH access commands are also output for convenience.

```
opc_compute_instance.elk (remote-exec): Monitored logstash
opc_compute_instance.elk (remote-exec): #########################################################################
opc_compute_instance.elk (remote-exec): #                                                                       #
opc_compute_instance.elk (remote-exec): #        Setting Bitnami application password to 'zdjwJ0scjekj'         #
opc_compute_instance.elk (remote-exec): #                                                                       #
opc_compute_instance.elk (remote-exec): #########################################################################
opc_compute_instance.elk: Still creating... (11m30s elapsed)
opc_compute_instance.elk: Creation complete (ID: 595e2ea4-ef9e-40a5-869d-46f247c2227e)

Apply complete! Resources: 7 added, 0 changed, 0 destroyed.

Outputs:

base_url = http://129.144.27.18
docs = https://docs.bitnami.com/oracle/apps/elk/
elk_url = http://129.144.27.18/elk
ssh = ssh bitnami@129.144.27.18 -i ./id_rsa
```

Proceed to **Step 3** of the [Bitnami ELK For Oracle Cloud documentation](https://docs.bitnami.com/oracle/apps/elk/) to configure Kibana
