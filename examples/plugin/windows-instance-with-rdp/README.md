Terraform Configuration for Windows Server 2012 R2
==================================================

This example lauches a single Windows 2012 R2 instance using the image from the Oracle Cloud Marketplace and enabled Remote Desktop access

-	Launches a new Windows Server 2012 R2 instance `windows-server-1` with an initial Adminstrator password configured.
-	Creates a new public ip address reservation for the instance.
-	Creates a new security list `Enable-RDP-access` and associates the security list instanace.
-	Creates a new `Allow-rdp-access` security rule to allow RDP traffic from the public internet to the `Enable-RDP-access` security list.

Usage
-----

### Prerequisites

First Install the [Microsoft Windows 2012 R2 image](https://cloud.oracle.com/marketplace/en_US/listing/7055818) from the Oracle Cloud Marketplace to your Oracle Compute Cloud account so the Windows Server image is available in your domain.

Create a `terraform.tfvars` to file to set your environment specific credentials

```
user = "user@example.com"
password = "XXXXXXXX"
domain = "usexample54321"
endpoint = "https://api-z27.compute.us6.oraclecloud.com/"

administrator_password = "ADMINPA$$WORD#123"
```

Where `adminstrator_password` is the initial Windows Administrator password that will be set when lauching the Windows Server instance. If the administrator password is ommited from the `terraform.tfvars` it will be prompted for when applying the configuration, or can be set as an environment variable `TF_VAR_administrator_password`

### Apply the configuration

First review the configuration plan of the resources that will be created.

```
$ terraform plan
```

Then apply the configuration.

```
$ terraform apply
```

Once the image has fully launched (this can take several minutes) connect to the instance using a Windows Remote Desktop Client.

### Access the server

You can find the Public IP Address that was assigned to the instance in the Oracle Compute Cloud console, or inspect the terraform configuration for the opc_compute_ip_reservation.ipreservation1.ip

```
$ terraform show | grep -A 2 opc_compute_ip_reservation.ipreservation1
opc_compute_ip_reservation.ipreservation1:
  id = 8ee43eb8-ded1-4c41-9578-b301425ed5e7
  ip = 129.152.148.130
```

Login to the remote instance as `\Administrator` using the administrator password set when applying the configuration.

### Clean-up

To destroy instance and clean-up all the dependent configuration

```sh
terraform destroy
```

Related Inforamtion
-------------------

-	[Accessing a Windows Instance Using RDP](https://docs.oracle.com/cloud/latest/stcomputecs/STCSG/GUID-08D93BEF-6FE4-4815-AC4F-30396ED69830.htm#STCSG-GUID-08D93BEF-6FE4-4815-AC4F-30396ED69830)
