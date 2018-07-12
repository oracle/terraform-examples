Example Load Balancer Classic Terraform Configuration
=====================================================


This example demonstrates how to configure the Oracle Cloud Infrastructure Load Balancer Classic service using Terraform

The example creates a complete application deployment include the the backend servers and load balance the traffic beens the deployed web applications.  The configuration is split into 4 sub modules:

- `network` creates the IP Network for the server and load balancer deployment
- `server_pool` creates a requested number of Oracle Cloud Infrastructure Classic compute instances on on the configured IP Network
- `webapp` deploys an example web application to each of the provisioned server instances
- `security_rules` creates the security rule resources used to configure the server SSH and web app port access rules.
- `load_balancer` created the load balancer instances configured to balance the traffic between the servers in the server pool

Note this example assumes the load balancer is being setup to load balance a site at the fictional address `mydomain.example.com`.   To see the load balancer actually working this hostname should be changed to a domain you have access to in order to update the public DNS CNAME record so the host is redirected to the load balancers canonical host name.

Steps:

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

- Adjust the `server_count` and `dns_names` local variables if required.

- Deploy the configuration

  ```sh
  $ terraform apply
  ```
