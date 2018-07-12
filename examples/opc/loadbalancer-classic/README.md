Example Load Balancer Classic Terraform Configuration
=====================================================


This example demonstrates how to configure the Oracle Cloud Infrastructure Load Balancer Classic service using Terraform

The example creates a complete application deployment include the the backend servers and load balance the traffic beens the deployed web applications.  The configuration is split into 4 sub modules:

- `network` creates the IP Network for the server and load balancer deployment
- `server_pool` creates a requested number of Oracle Cloud Infrastructure Classic compute instances on on the configured IP Network
- `webapp` deploys an example web application to each of the provisioned server instances
- `load_balancer` created the load balancer instances configured to balance the traffic between the servers in the server pool


- Generate an ssh key pair for use deploying this example (no passphrase)

```sh
$ ssh-keygen -f ./id_rsa
```

- Create a local `terraform.tfvars` file with your environment specific credentials

  ```
  domain="55500000"
  endpoint="https://compute.uscom-central-1.oraclecloud.com/"
  user="user@example.com"
  password="Pa55_Word"
  region="uscom-central-1"
  lbaas_endpoint= "https://lbaas-11111111.balancer.oraclecloud.com"
  ```


- Deploy the configuration

  ```sh
  $ terraform apply
  ```
