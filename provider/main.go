package main

import (
	"github.com/hashicorp/terraform/plugin"
	"github.com/oracle/terraform/provider/opc"
)

func main() {
	plugin.Serve(&plugin.ServeOpts{
		ProviderFunc: opc.Provider})
}
