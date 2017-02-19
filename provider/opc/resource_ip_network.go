package opc

import (
	"fmt"
	"github.com/hashicorp/terraform/helper/schema"
	"github.com/oracle/terraform-provider-compute/sdk/compute"
	"log"
)

func resourceIPNetwork() *schema.Resource {
	return &schema.Resource{
		Create: resourceIPNetworkCreate,
		Read:   resourceIPNetworkRead,
		Update: resourceIPNetworkUpdate,
		Delete: resourceIPNetworkDelete,

		Schema: map[string]*schema.Schema{
			"name": &schema.Schema{
				Type:     schema.TypeString,
				Required: true,
				ForceNew: true,
			},

			"ip_address_prefix": &schema.Schema{
				Type:     schema.TypeString,
				Required: true,
				ForceNew: false,
			},

			"ip_network_exchange": &schema.Schema{
				Type:     schema.TypeString,
				Optional: true,
				ForceNew: false,
			},

			"description": &schema.Schema{
				Type:     schema.TypeString,
				Optional: true,
				ForceNew: false,
			},

			"tags": &schema.Schema{
				Type:     schema.TypeSet,
				Optional: true,
				ForceNew: false,
				Elem:     &schema.Schema{Type: schema.TypeString},
			},

			"uri": &schema.Schema{
				Type:     schema.TypeString,
				Optional: false,
				Computed: true,
			},
		},
	}
}

func resourceIPNetworkCreate(d *schema.ResourceData, meta interface{}) error {
	log.Printf("[DEBUG] Resource data: %#v", d)

	client := meta.(*OPCClient).IPNetworks()
	name := d.Get("name").(string)
	ipAddressPrefix := d.Get("ip_address_prefix").(string)
	ipNetworkExchange := d.Get("ip_network_exchange").(string)
	description := d.Get("description").(string)
	tags := getTags(d)

	info, err := client.CreateIPNetwork(name, ipAddressPrefix, ipNetworkExchange, description, tags)
	if err != nil {
		return fmt.Errorf("Error creating ip network %s: %s", name, err)
	}

	d.SetId(info.Name)
	updateIPNetworkResourceData(d, info)
	return nil
}

func updateIPNetworkResourceData(d *schema.ResourceData, info *compute.IPNetworkInfo) {
	d.Set("name", info.Name)
	d.Set("ip_address_prefix", info.IPAddressPrefix)
	d.Set("ip_network_exchange", info.IPNetworkExchange)
	d.Set("description", info.Description)
	d.Set("tags", info.Tags)
	d.Set("uri", info.URI)
}

func resourceIPNetworkRead(d *schema.ResourceData, meta interface{}) error {
	log.Printf("[DEBUG] Resource data: %#v", d)
	client := meta.(*OPCClient).IPNetworks()
	name := d.Get("name").(string)

	log.Printf("[DEBUG] Reading state of ip network %s", name)
	result, err := client.GetIPNetwork(name)
	if err != nil {
		// SSH Key does not exist
		if compute.WasNotFoundError(err) {
			d.SetId("")
			return nil
		}
		return fmt.Errorf("Error reading ip network %s: %s", name, err)
	}

	log.Printf("[DEBUG] Read state of ip network %s: %#v", name, result)
	updateIPNetworkResourceData(d, result)
	return nil
}

func resourceIPNetworkUpdate(d *schema.ResourceData, meta interface{}) error {
	log.Printf("[DEBUG] Resource data: %#v", d)

	client := meta.(*OPCClient).IPNetworks()
	name := d.Get("name").(string)
	ipAddressPrefix := d.Get("ip_address_prefix").(string)
	ipNetworkExchange := d.Get("ip_network_exchange").(string)
	description := d.Get("description").(string)
	tags := getTags(d)

	info, err := client.UpdateIPNetwork(name, ipAddressPrefix, ipNetworkExchange, description, tags)
	if err != nil {
		return fmt.Errorf("Error updating ip network %s: %s", name, err)
	}

	updateIPNetworkResourceData(d, info)
	return nil
}

func resourceIPNetworkDelete(d *schema.ResourceData, meta interface{}) error {
	log.Printf("[DEBUG] Resource data: %#v", d)
	client := meta.(*OPCClient).IPNetworks()
	name := d.Get("name").(string)

	log.Printf("[DEBUG] Deleting ip network %s", name)
	if err := client.DeleteIPNetwork(name); err != nil {
		return fmt.Errorf("Error deleting ip network %s: %s", name, err)
	}
	return nil
}
