Terraform Provider for Oracle Compute Cloud
===========================================

Requirements
------------

* Go 1.6
* Oracle Public Cloud Account

Building
--------

```sh
$ cd $GOPATH/src/github.com/oracle/terraform/provider
$ go build
```

Then add the generated `provider` file to your `.terraformrc`

Running tests
-------------

The SDK tests includes integration tests, therefore it requires a valid Oracle Public Account. The account to which the tests will be pointed is configured through the following environment variables:

* `OPC_ENDPOINT` - Endpoint provided by Oracle Public Cloud (e.g. https://api-z13.compute.em2.oraclecloud.com/)
* `OPC_USERNAME` - Username for Oracle Public Cloud
* `OPC_PASSWORD` - Password for Oracle Public Cloud
* `OPC_IDENTITY_DOMAIN` - Identity domain for Oracle Public Cloud

```sh
$ # OCP_* variables must have been exported 
$ cd $GOPATH/src/github.com/oracle/terraform/sdk/compute 
$ go test
```
