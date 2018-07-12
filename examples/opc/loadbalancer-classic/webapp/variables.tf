variable "name" {}
variable "servers" {
  type = "list"
}

variable "server_acl" {}
variable "server_count" {}
variable "ssh_user" {}
variable "private_ssh_key_file" {}
variable "public_ssh_key_file" {}
