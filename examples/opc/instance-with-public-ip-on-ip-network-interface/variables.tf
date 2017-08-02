variable "user" {}
variable "password" {}
variable "domain" {}
variable "endpoint" {}

variable "public_ssh_key" {
  default = "~/.ssh/id_rsa.pub"
}
