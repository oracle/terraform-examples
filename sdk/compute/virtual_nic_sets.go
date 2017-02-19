package compute

// VirtualNicSetsClient is a client for the IP Network Excahnges functions of the Compute API.
type VirtualNicSetsClient struct {
	*ResourceClient
}

// VirtualNicSets obtains an VirtualNicSetsClient which can be used to access to the
// IP Network Exchanges functions of the Compute API
func (c *AuthenticatedClient) VirtualNicSets() *VirtualNicSetsClient {
	return &VirtualNicSetsClient{
		ResourceClient: &ResourceClient{
			AuthenticatedClient: c,
			ResourceDescription: "virtual nic set",
			ContainerPath:       "/network/v1/vnicset/",
			ResourceRootPath:    "/network/v1/vnicset",
		}}
}

// VirtualNicSetSpec defines an virtual nic set to be created.
type VirtualNicSetSpec struct {
	Name        string   `json:"name"`
	// VirtualNics []string `json:"vnics,omitempty"`
	Description string   `json:"description"`
	Tags        []string `json:"tags"`
}

// VirtualNicSetInfo describes an existing virtual nic set.
type VirtualNicSetInfo struct {
	Name        string   `json:"name"`
	// VirtualNics []string `json:"vnics"`
	Description string   `json:"description"`
	Tags        []string `json:"tags"`
	URI         string   `json:"uri"`
}

func (c *VirtualNicSetsClient) success(result *VirtualNicSetInfo) (*VirtualNicSetInfo, error) {
	c.unqualify(&result.Name)
	return result, nil
}

// CreateVirtualNicSet creates a new virtual nic set.
func (c *VirtualNicSetsClient) CreateVirtualNicSet(name, description string, virtualNics, tags []string) (*VirtualNicSetInfo, error) {
	qualifiedVirtualNics := []string{}
	for _, key := range virtualNics {
		qualifiedVirtualNics = append(qualifiedVirtualNics, c.getQualifiedName(key))
	}

	spec := VirtualNicSetSpec{
		Name: c.getQualifiedName(name),
		// VirtualNics: qualifiedVirtualNics,
		Description: description,
		Tags: tags,
	}

	var info VirtualNicSetInfo
	if err := c.createResource(&spec, &info); err != nil {
		return nil, err
	}
	return c.success(&info)
}

// GetVirtualNicSet retrieves the virtual nic set with the given name.
func (c *VirtualNicSetsClient) GetVirtualNicSet(name string) (*VirtualNicSetInfo, error) {
	var info VirtualNicSetInfo
	if err := c.getResource(name, &info); err != nil {
		return nil, err
	}
	return c.success(&info)
}

// UpdateVirtualNicSet updates the virtual nic set details.
func (c *VirtualNicSetsClient) UpdateVirtualNicSet(name, description string, virtualNics, tags []string) (*VirtualNicSetInfo, error) {
	// qualifiedVirtualNics := []string{}
	// for _, key := range virtualNics {
	// 	qualifiedVirtualNics = append(qualifiedVirtualNics, c.getQualifiedName(key))
	// }

	spec := VirtualNicSetSpec{
		Name: c.getQualifiedName(name),
		// VirtualNics: qualifiedVirtualNics,
		Description: description,
		Tags: tags,
	}

	var info VirtualNicSetInfo
	if err := c.updateResource(name, &spec, &info); err != nil {
		return nil, err
	}

	return c.success(&info)
}

// DeleteVirtualNicSet deletes the virtual nic set with the given name.
func (c *VirtualNicSetsClient) DeleteVirtualNicSet(name string) error {
	return c.deleteResource(name)
}
