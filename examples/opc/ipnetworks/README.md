IP Networks Example
===================

This terraform configuration creates an example IP network topology based on the scenario illustrated in the [Oracle Compute Cloud About IP Networks ](http://docs.oracle.com/cloud/latest/stcomputecs/STCSG/GUID-7299731F-7AEB-41F2-9938-2066CE7648F2.htm#STCSG-GUID-7299731F-7AEB-41F2-9938-2066CE7648F2) documentation.

![IP Network Diagram](http://docs.oracle.com/cloud/latest/stcomputecs/STCSG/img/GUID-C4B6EEFA-27E1-40DA-BF8C-B77681DDDCD3-default.png)

This example configures the IP Networks and IP Address on the IP Networks as shown in the diagram. The Private IP Addresses on the Shared Network, and two Public IP Addresses will vary as they are dynamically allocated.

In addition this example also configures an SSH key for access to all of the instances and copies the ssh private key to the Instance_3 and Instance_4 to enable sshing through the instances on the private IP networks.

This configuration will create:

-	5 Compute Instances: `Instance_1`, `Instance_2`, `Instance_3`, `Instance_4`, `Instance_5`
-	3 IP Networks: `IP_Network1`, `IP_Network2`, `IP_Network3`
-	1 IP Network Exchange: `IPExchange`
-	1 SSH Key: `ip-network-example-key`
-	2 Public IP Reservations: `reservation1`, `reservation2`

Usage
-----

### Set account variables

Create a `terraform.tfvars` to set the Oracle Compute Cloud authentication credentials.

### Setup SSH Keys for instance access

First create an ssh key pair to be used access the instances. The following will create `id_rsa` and `id_rsa.pub` in the local directory.

```sh
$ ssh-keygen -f ./id_rsa -N "" -q
```

Alternatively the `ssh_public_key` and `ssh_private_key` variables can be set in `terraform.tfvars` to the file location of an existing ssh key pair.

### Apply the configuration

This example uses modules, to prepare terraform the use the module first run

```
$ terraform get
```

Review the configuraion terraform will create

```
$ terraform plan
```

Now apply the configuration

```
$ terraform apply
```

Wait for the configuration to complete

### Access the instances and check the configuration

You can ssh directly to Instance_3 and Instance_4. The Public IP Addresses assinged to these instances is output at the end of the `terraform apply`.

e.g. SSH to Instance_3

```
$ ssh opc@129.152.148.130 -i ./id_rsa
```

Once connected to the Instance_3 you can access Instance_2 and Instance_1 using the staically assigned IP addresses in the IP Networks. Instance_4 and Instance_5 are not accessable from Instance_3 as they are on a different IP Network.

```
[opc@instance3 ~]$ ping 192.168.3.11
PING 192.168.3.11 (192.168.3.11) 56(84) bytes of data.
64 bytes from 192.168.3.11: icmp_seq=1 ttl=64 time=0.586 ms

[opc@instance3 ~]$ ssh opc@192.168.2.16
[opc@instance1 ~]$
```

### Destroy the configuration

Cleanup all instances and resources created

```
$ terraform destroy
```
