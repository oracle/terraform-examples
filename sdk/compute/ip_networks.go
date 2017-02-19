package compute

// IPNetworksClient is a client for the IP Networks functions of the Compute API.
type IPNetworksClient struct {
	*ResourceClient
}

// IPNetworks obtains an IPNetworksClient which can be used to access to the
// IP Networks functions of the Compute API
func (c *AuthenticatedClient) IPNetworks() *IPNetworksClient {
	return &IPNetworksClient{
		ResourceClient: &ResourceClient{
			AuthenticatedClient: c,
			ResourceDescription: "ip network",
			ContainerPath:       "/network/v1/ipnetwork/",
			ResourceRootPath:    "/network/v1/ipnetwork",
		}}
}

// IPNetworkSpec defines an IP network to be created.
type IPNetworkSpec struct {
	Name              string   `json:"name"`
	IPAddressPrefix   string   `json:"ipAddressPrefix"`
	IPNetworkExchange string   `json:"ipNetworkExchange"`
	Description       string   `json:"description"`
	Tags              []string `json:"tags"`
}

// IPNetworkInfo describes an existing IP network.
type IPNetworkInfo struct {
	Name              string   `json:"name"`
	IPAddressPrefix   string   `json:"ipAddressPrefix"`
	IPNetworkExchange string   `json:"ipNetworkExchange"`
	Description       string   `json:"description"`
	Tags              []string `json:"tags"`
	URI               string   `json:"uri"`
}

func (c *IPNetworksClient) success(result *IPNetworkInfo) (*IPNetworkInfo, error) {
	c.unqualify(&result.Name)
	return result, nil
}

// CreateIPNetwork creates a new IP network.
func (c *IPNetworksClient) CreateIPNetwork(name, ipAddressPrefix, ipNetworkExchange, description string, tags []string) (*IPNetworkInfo, error) {
	spec := IPNetworkSpec{
		Name:              c.getQualifiedName(name),
		IPAddressPrefix:   ipAddressPrefix,
		IPNetworkExchange: c.getQualifiedName(ipNetworkExchange),
		Description:       description,
		Tags:              tags,
	}
	var ipInfo IPNetworkInfo
	if err := c.createResource(&spec, &ipInfo); err != nil {
		return nil, err
	}

	return c.success(&ipInfo)
}

// GetIPNetwork retrieves the IP network with the given name.
func (c *IPNetworksClient) GetIPNetwork(name string) (*IPNetworkInfo, error) {
	var ipInfo IPNetworkInfo
	if err := c.getResource(name, &ipInfo); err != nil {
		return nil, err
	}

	ipInfo.IPNetworkExchange = c.getUnqualifiedName(ipInfo.IPNetworkExchange)

	return c.success(&ipInfo)
}

// UpdateIPNetwork updates the ip network details.
func (c *IPNetworksClient) UpdateIPNetwork(name, ipAddressPrefix, ipNetworkExchange, description string, tags []string) (*IPNetworkInfo, error) {
	spec := IPNetworkSpec{
		Name:              c.getQualifiedName(name),
		IPAddressPrefix:   ipAddressPrefix,
		IPNetworkExchange: c.getQualifiedName(ipNetworkExchange),
		Description:       description,
		Tags:              tags,
	}

	var ipInfo IPNetworkInfo
	if err := c.updateResource(name, &spec, &ipInfo); err != nil {
		return nil, err
	}

	return c.success(&ipInfo)
}

// DeleteIPNetwork deletes the IP reservation with the given name.
func (c *IPNetworksClient) DeleteIPNetwork(name string) error {
	return c.deleteResource(name)
}
