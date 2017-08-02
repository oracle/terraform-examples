Compute Instance with Public IP Address Reservation on an IP Network Interface
==============================================================================

This example demonstrates the creation of a compute instance with the Public IP address assigned to the IP Network interface.

The Terraform configuration creates the following resources:

-	**IP Network** `my-ip-network`
-	**IP Address Reservation** `my-ip-address` for an public IP address reservation on the IP Network
-	**Compute Instance** `my-instance` OL 7.2 UEK4 instance with one interface on the IP Network associated to the Public IP Address reservation.
-	**SSH Key** `my-ssh-key` for SSH access the instance (defaults to `~/.ssh/id_rsa.pub`\)
-	**Access Control List** `my-acl` for associating the security rules to the Virtual NIC Set
-	**Security Rule** `Allow-ssh-ingress` to allow ingress SSH traffic
-	**Security Rule** `Allow-all-egress` to allow all outbound traffic
-	**Security Protocol** `all` to match all traffic
-	**Security Protocol** `ssh` to match ssh traffic to TCP port 22
-	**Virtual NIC Set** `my-vnic-set` to associate instance interfaces to the ACL
