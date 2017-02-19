package compute

// IPNetworkExchangesClient is a client for the IP Network Excahnges functions of the Compute API.
type IPNetworkExchangesClient struct {
	*ResourceClient
}

// IPNetworkExchanges obtains an IPNetworkExchangesClient which can be used to access to the
// IP Network Exchanges functions of the Compute API
func (c *AuthenticatedClient) IPNetworkExchanges() *IPNetworkExchangesClient {
	return &IPNetworkExchangesClient{
		ResourceClient: &ResourceClient{
			AuthenticatedClient: c,
			ResourceDescription: "ip network exchange",
			ContainerPath:       "/network/v1/ipnetworkexchange/",
			ResourceRootPath:    "/network/v1/ipnetworkexchange",
		}}
}

// IPNetworkExchangeSpec defines an IP network exchange to be created.
type IPNetworkExchangeSpec struct {
	Name        string   `json:"name"`
	Description string   `json:"description"`
	Tags        []string `json:"tags"`
}

// IPNetworkExchangeInfo describes an existing IP network.
type IPNetworkExchangeInfo struct {
	Name        string   `json:"name"`
	Description string   `json:"description"`
	Tags        []string `json:"tags"`
	URI         string   `json:"uri"`
}

func (c *IPNetworkExchangesClient) success(result *IPNetworkExchangeInfo) (*IPNetworkExchangeInfo, error) {
	c.unqualify(&result.Name)
	return result, nil
}

// CreateIPNetworkExchange creates a new IP network exchange.
func (c *IPNetworkExchangesClient) CreateIPNetworkExchange(spec *IPNetworkExchangeSpec) (*IPNetworkExchangeInfo, error) {
	spec.Name = c.getQualifiedName(spec.Name)
	var info IPNetworkExchangeInfo
	if err := c.createResource(&spec, &info); err != nil {
		return nil, err
	}
	return c.success(&info)
}

// GetIPNetworkExchange retrieves the IP network exchange with the given name.
func (c *IPNetworkExchangesClient) GetIPNetworkExchange(name string) (*IPNetworkExchangeInfo, error) {
	var info IPNetworkExchangeInfo
	if err := c.getResource(name, &info); err != nil {
		return nil, err
	}
	return c.success(&info)
}

// UpdateIPNetworkExchange updates the ip network details.
func (c *IPNetworkExchangesClient) UpdateIPNetworkExchange(spec *IPNetworkExchangeSpec) (*IPNetworkExchangeInfo, error) {
	name := spec.Name
	spec.Name = c.getQualifiedName(spec.Name)
	var info IPNetworkExchangeInfo
	if err := c.updateResource(name, &spec, &info); err != nil {
		return nil, err
	}

	return c.success(&info)
}

// DeleteIPNetworkExchange deletes the IP reservation with the given name.
func (c *IPNetworkExchangesClient) DeleteIPNetworkExchange(name string) error {
	return c.deleteResource(name)
}
