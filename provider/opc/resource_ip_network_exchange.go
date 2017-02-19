package opc

import (
	"fmt"
	"github.com/hashicorp/terraform/helper/schema"
	"github.com/oracle/terraform-provider-compute/sdk/compute"
	"log"
)

func resourceIPNetworkExchange() *schema.Resource {
	return &schema.Resource{
		Create: resourceIPNetworkExchangeCreate,
		Read:   resourceIPNetworkExchangeRead,
		Update: resourceIPNetworkExchangeUpdate,
		Delete: resourceIPNetworkExchangeDelete,

		Schema: map[string]*schema.Schema{
			"name": &schema.Schema{
				Type:     schema.TypeString,
				Required: true,
				ForceNew: true,
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

func resourceIPNetworkExchangeCreate(d *schema.ResourceData, meta interface{}) error {
	log.Printf("[DEBUG] Resource data: %#v", d)

	client := meta.(*OPCClient).IPNetworkExchanges()
	spec := compute.IPNetworkExchangeSpec{
		Name: d.Get("name").(string),
	}

	if d.Get("description").(string) != "" {
		spec.Description = d.Get("description").(string)
	}
	spec.Tags = getTags(d)

	log.Printf("[DEBUG] Creating ip network exchange %s with spec %#v", spec.Name, spec)

	info, err := client.CreateIPNetworkExchange(&spec)
	if err != nil {
		return fmt.Errorf("Error creating ip network exchange %s: %s", spec.Name, err)
	}

	d.SetId(info.Name)
	updateIPNetworkExchangeResourceData(d, info)
	return nil
}

func updateIPNetworkExchangeResourceData(d *schema.ResourceData, info *compute.IPNetworkExchangeInfo) {
	d.Set("name", info.Name)
	d.Set("description", info.Description)
	d.Set("tags", info.Tags)
	d.Set("uri", info.URI)
}

func resourceIPNetworkExchangeRead(d *schema.ResourceData, meta interface{}) error {
	log.Printf("[DEBUG] Resource data: %#v", d)
	client := meta.(*OPCClient).IPNetworkExchanges()
	name := d.Get("name").(string)

	log.Printf("[DEBUG] Reading state of ip network exchange %s", name)
	result, err := client.GetIPNetworkExchange(name)
	if err != nil {
		if compute.WasNotFoundError(err) {
			d.SetId("")
			return nil
		}
		return fmt.Errorf("Error reading ip network exchange %s: %s", name, err)
	}

	log.Printf("[DEBUG] Read state of ip network exchange %s: %#v", name, result)
	updateIPNetworkExchangeResourceData(d, result)
	return nil
}

func resourceIPNetworkExchangeUpdate(d *schema.ResourceData, meta interface{}) error {
	log.Printf("[DEBUG] Resource data: %#v", d)

	client := meta.(*OPCClient).IPNetworkExchanges()
	spec := compute.IPNetworkExchangeSpec{
		Name: d.Get("name").(string),
		Description: d.Get("description").(string),
		Tags: getTags(d),
	}

	log.Printf("[DEBUG] Updating ip network with name %s, spec %#v", spec.Name, spec)

	info, err := client.UpdateIPNetworkExchange(&spec)
	if err != nil {
		return fmt.Errorf("Error updating ip network exchange %s: %s", spec.Name, err)
	}

	updateIPNetworkExchangeResourceData(d, info)
	return nil
}

func resourceIPNetworkExchangeDelete(d *schema.ResourceData, meta interface{}) error {
	log.Printf("[DEBUG] Resource data: %#v", d)
	client := meta.(*OPCClient).IPNetworkExchanges()
	name := d.Get("name").(string)

	log.Printf("[DEBUG] Deleting ip network %s", name)
	if err := client.DeleteIPNetworkExchange(name); err != nil {
		return fmt.Errorf("Error deleting ip network %s: %s", name, err)
	}
	return nil
}
