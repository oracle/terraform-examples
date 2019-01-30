// Copyright (c) 2017, 2019, Oracle and/or its affiliates. All rights reserved.

variable user {}
variable password {}
variable domain {}
variable endpoint {}

variable ssh_user {
  description = "User account for ssh access to the image"
  default     = "opc"
}

variable ssh_private_key {
  description = "File location of the ssh private key"
  default     = "./id_rsa"
}

variable ssh_public_key {
  description = "File location of the ssh public key"
  default     = "./id_rsa.pub"
}
