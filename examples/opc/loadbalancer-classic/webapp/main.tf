variable "servers" {
  type = "list"
}

variable "server_count" {}
variable "ssh_user" {}
variable "private_ssh_key_file" {}
variable "public_ssh_key_file" {}

resource "null_resource" "install_go" {
  count = "${var.server_count}"

  connection {
    type        = "ssh"
    host        = "${element(var.servers,count.index)}"
    user        = "${var.ssh_user}"
    private_key = "${file(var.private_ssh_key_file)}"
    timeout     = "30m"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo yum install -y git",
      "curl https://dl.google.com/go/go1.10.3.linux-amd64.tar.gz -o go1.10.3.linux-amd64.tar.gz",
      "sudo tar -C /usr/local -xzf go1.10.3.linux-amd64.tar.gz",
      "echo 'export PATH=$PATH:/usr/local/go/bin' >> ~/.bash_profile",
    ]
  }

  provisioner "remote-exec" {
    when = "destroy"

    inline = [
      "sudo rm -f /usr/local/go",
      "rm go1.10.3.linux-amd64.tar.gz",
      "sed -i '/PATH=$PATH:\\/usr\\/local\\/go\\/bin/d' ~/.bash_profile",
    ]
  }
}

resource "null_resource" "install_server" {
  count = "${var.server_count}"

  triggers {
    install_go = "${null_resource.install_go.id}"
  }

  connection {
    type        = "ssh"
    host        = "${element(var.servers,count.index)}"
    user        = "${var.ssh_user}"
    private_key = "${file(var.private_ssh_key_file)}"
    timeout     = "30m"
  }

  provisioner "remote-exec" {
    inline = [
      "source ~/.bash_profile",
      "go get -u github.com/labstack/echo",
      "go get -u github.com/labstack/echo/middleware",
    ]
  }

  provisioner "file" {
    source      = "${path.module}/server.go"
    destination = "~/server.go"
  }

  provisioner "remote-exec" {
    when = "destroy"

    inline = [
      "go clean -i github.com/labstack/echo",
      "rm server.go",
    ]
  }
}

resource "null_resource" "start_server" {
  count = "${var.server_count}"

  triggers {
    install_go     = "${null_resource.install_go.id}"
    install_server = "${null_resource.install_server.id}"
    src            = "${md5(file("${path.module}/server.go"))}"
  }

  connection {
    type        = "ssh"
    host        = "${element(var.servers,count.index)}"
    user        = "${var.ssh_user}"
    private_key = "${file(var.private_ssh_key_file)}"
    timeout     = "30m"
  }

  provisioner "remote-exec" {
    inline = [
      "set -x",
      "source ~/.bash_profile",
      "go run server.go & || true",
    ]
  }

  provisioner "remote-exec" {
    when = "destroy"

    inline = [
      "set -x",
      "kill -9 `pgrep -f 'go run server.go'` `pgrep -f go-build` || true",
    ]
  }
}
