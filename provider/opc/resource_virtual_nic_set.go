package opc

import (
	"fmt"
	"github.com/hashicorp/terraform/helper/schema"
	"github.com/oracle/terraform-provider-compute/sdk/compute"
	"log"
)

func resourceVirtualNicSet() *schema.Resource {
	return &schema.Resource{
		Create: resourceVirtualNicSetCreate,
		Read:   resourceVirtualNicSetRead,
		Update: resourceVirtualNicSetUpdate,
		Delete: resourceVirtualNicSetDelete,

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

			"virtual_nics": &schema.Schema{
				Type:     schema.TypeSet,
				Optional: true,
				ForceNew: false,
				Elem:     &schema.Schema{Type: schema.TypeString},
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

func resourceVirtualNicSetCreate(d *schema.ResourceData, meta interface{}) error {
	log.Printf("[DEBUG] Resource data: %#v", d)

	client := meta.(*OPCClient).VirtualNicSets()
	name := d.Get("name").(string)
	description := d.Get("description").(string)
	tags := getTags(d)
	virtualNics := getVirtualNics(d)

	info, err := client.CreateVirtualNicSet(name, description, virtualNics, tags)
	if err != nil {
		return fmt.Errorf("Error creating ip network exchange %s: %s", name, err)
	}

	d.SetId(info.Name)
	updateVirtualNicSetResourceData(d, info)
	return nil
}

func updateVirtualNicSetResourceData(d *schema.ResourceData, info *compute.VirtualNicSetInfo) {
	d.Set("name", info.Name)
	d.Set("description", info.Description)
	d.Set("tags", info.Tags)
	d.Set("uri", info.URI)
}

func resourceVirtualNicSetRead(d *schema.ResourceData, meta interface{}) error {
	log.Printf("[DEBUG] Resource data: %#v", d)
	client := meta.(*OPCClient).VirtualNicSets()
	name := d.Get("name").(string)

	log.Printf("[DEBUG] Reading state of ip network exchange %s", name)
	result, err := client.GetVirtualNicSet(name)
	if err != nil {
		if compute.WasNotFoundError(err) {
			d.SetId("")
			return nil
		}
		return fmt.Errorf("Error reading ip network exchange %s: %s", name, err)
	}

	log.Printf("[DEBUG] Read state of ip network exchange %s: %#v", name, result)
	updateVirtualNicSetResourceData(d, result)
	return nil
}

func resourceVirtualNicSetUpdate(d *schema.ResourceData, meta interface{}) error {
	log.Printf("[DEBUG] Resource data: %#v", d)

	client := meta.(*OPCClient).VirtualNicSets()
	name := d.Get("name").(string)
	description := d.Get("description").(string)
	tags := getTags(d)
	virtualNics := getVirtualNics(d)

	info, err := client.UpdateVirtualNicSet(name, description, virtualNics, tags)
	if err != nil {
		return fmt.Errorf("Error updating ip network exchange %s: %s", name, err)
	}

	updateVirtualNicSetResourceData(d, info)
	return nil
}

func resourceVirtualNicSetDelete(d *schema.ResourceData, meta interface{}) error {
	log.Printf("[DEBUG] Resource data: %#v", d)
	client := meta.(*OPCClient).VirtualNicSets()
	name := d.Get("name").(string)

	log.Printf("[DEBUG] Deleting ip network %s", name)
	if err := client.DeleteVirtualNicSet(name); err != nil {
		return fmt.Errorf("Error deleting ip network %s: %s", name, err)
	}
	return nil
}

func getVirtualNics(d *schema.ResourceData) []string {
	vnicSet := &schema.Set{}
  vnicSet = d.Get("virtual_nics").(*schema.Set)
	vnics := []string{}
	for _, i := range vnicSet.List() {
		vnics = append(vnics, i.(string))
	}
	return vnics
}
