package opc

import (
	"fmt"
	"github.com/hashicorp/terraform/helper/schema"
	"github.com/oracle/terraform-provider-compute/sdk/compute"
	"log"
)

func resourceIPRoute() *schema.Resource {
	return &schema.Resource{
		Create: resourceIPRouteCreate,
		Read:   resourceIPRouteRead,
		Update: resourceIPRouteUpdate,
		Delete: resourceIPRouteDelete,

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

			"next_hop_virtual_nic_set": &schema.Schema{
				Type:     schema.TypeString,
				Required: true,
				ForceNew: false,
			},

			"admin_distance": &schema.Schema{
				Type:     schema.TypeInt,
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

func resourceIPRouteCreate(d *schema.ResourceData, meta interface{}) error {
	log.Printf("[DEBUG] Resource data: %#v", d)

	client := meta.(*OPCClient).IPRoutes()
	name := d.Get("name").(string)
	ipAddressPrefix := d.Get("ip_address_prefix").(string)
	nextHopVirtualNicSet := d.Get("next_hop_virtual_nic_set").(string)
	adminDistance := d.Get("admin_distance").(int)
	description := d.Get("description").(string)
	tags := getTags(d)

	info, err := client.CreateIPRoute(name, description, ipAddressPrefix, nextHopVirtualNicSet, adminDistance, tags)
	if err != nil {
		return fmt.Errorf("Error creating ip network %s: %s", name, err)
	}

	d.SetId(info.Name)
	updateIPRouteResourceData(d, info)
	return nil
}

func updateIPRouteResourceData(d *schema.ResourceData, info *compute.IPRouteInfo) {
	d.Set("name", info.Name)
	d.Set("ip_address_prefix", info.IPAddressPrefix)
	d.Set("next_hop_virtual_nic_set", info.NextHopVnicSet)
	d.Set("admin_distance", info.AdminDistance)
	d.Set("description", info.Description)
	d.Set("tags", info.Tags)
	d.Set("uri", info.URI)
}

func resourceIPRouteRead(d *schema.ResourceData, meta interface{}) error {
	log.Printf("[DEBUG] Resource data: %#v", d)
	client := meta.(*OPCClient).IPRoutes()
	name := d.Get("name").(string)

	log.Printf("[DEBUG] Reading state of ip network %s", name)
	result, err := client.GetIPRoute(name)
	if err != nil {
		// SSH Key does not exist
		if compute.WasNotFoundError(err) {
			d.SetId("")
			return nil
		}
		return fmt.Errorf("Error reading ip network %s: %s", name, err)
	}

	log.Printf("[DEBUG] Read state of ip network %s: %#v", name, result)
	updateIPRouteResourceData(d, result)
	return nil
}

func resourceIPRouteUpdate(d *schema.ResourceData, meta interface{}) error {
	log.Printf("[DEBUG] Resource data: %#v", d)

	client := meta.(*OPCClient).IPRoutes()
	name := d.Get("name").(string)
	ipAddressPrefix := d.Get("ip_address_prefix").(string)
	nextHopVirtualNicSet := d.Get("next_hop_virtual_nic_set").(string)
	description := d.Get("description").(string)
	tags := getTags(d)
	adminDistance := d.Get("admin_distance").(int)

	info, err := client.UpdateIPRoute(name, description, ipAddressPrefix, nextHopVirtualNicSet, adminDistance, tags)
	if err != nil {
		return fmt.Errorf("Error updating ip network %s: %s", name, err)
	}

	updateIPRouteResourceData(d, info)
	return nil
}

func resourceIPRouteDelete(d *schema.ResourceData, meta interface{}) error {
	log.Printf("[DEBUG] Resource data: %#v", d)
	client := meta.(*OPCClient).IPRoutes()
	name := d.Get("name").(string)

	log.Printf("[DEBUG] Deleting ip network %s", name)
	if err := client.DeleteIPRoute(name); err != nil {
		return fmt.Errorf("Error deleting ip network %s: %s", name, err)
	}
	return nil
}
