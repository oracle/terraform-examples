Bastion Host Module
===================

This module create a bastion instance with a public ip address on the Shared Network interface enabled for SSH access.

Example Usage
-------------

```hcl
module "bastion-host" {
  source             = "../../terraform-opc-bastion"
  ssh_public_key     = "${opc_compute_ssh_key.bastion.name}"
  ssh_private_key    = "${file("~/.ssh/bastion_id_rsa")}"
  private_ip_network = "${opc_compute_ip_network.private-ip-network.name}"
}

resource "null_resource" "private-provisioner" {

  connection {
    type        = "ssh"
    host        = "${opc_compute_instance.private-instance.ip_address}"
    user        = "opc"
    private_key = "${file("~/.ssh/app_id_rsa")}"

    bastion_host        = "${module.bastion-host.bastion_public_ip}"
    bastion_user        = "${module.bastion-host.bastion_user}"
    bastion_private_key = "${module.bastion-host.bastion_private_key}"
  }

  provisioner "remote-exec" {
    inline = [
      ...
    ]
  }
}
```

Inputs
------

| Name               | Description                                                      | Type   | Default                              | Required |
|--------------------|------------------------------------------------------------------|:------:|:------------------------------------:|:--------:|
| hostname           | (Optional) name of the host. Default is `bastion`                | string |              `bastion`               |    no    |
| image              | (Optional) Machine image. Default is Oracle Linux 7.2 R4         | string | `/oracle/public/OL_7.2_UEKR4_x86_64` |    no    |
| private_ip_network | (Required) Name of the IP Network for private interface          | string |                  \-                  |   yes    |
| ssh_private_key    | (Required) SSH private key. E.g. `${file("~/.ssh/id_rsa")}`      | string |                  \-                  |   yes    |
| ssh_public_key     | (Required) Name of existing SSH Key resource                     | string |                  \-                  |   yes    |
| ssh_user           | (Optional) SSH user to connect to bastion host. Default is `opc` | string |                `opc`                 |    no    |

Outputs
-------

| Name                | Description                    |
|---------------------|--------------------------------|
| bastion_private_key | Bastion private ssh key        |
| bastion_public_ip   | Bastion host Public IP address |
| bastion_public_key  | Bastion ssh key resource       |
| bastion_user        | Bastion user                   |
