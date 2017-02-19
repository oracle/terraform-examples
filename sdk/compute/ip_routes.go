package compute

// IPRoutesClient is a client for the IP Routes functions of the Compute API.
type IPRoutesClient struct {
	*ResourceClient
}

// IPRoutes obtains an IPRoutesClient which can be used to access to the
// IP Routes functions of the Compute API
func (c *AuthenticatedClient) IPRoutes() *IPRoutesClient {
	return &IPRoutesClient{
		ResourceClient: &ResourceClient{
			AuthenticatedClient: c,
			ResourceDescription: "ip network",
			ContainerPath:       "/network/v1/route/",
			ResourceRootPath:    "/network/v1/route",
		}}
}

// IPRouteSpec defines an IP network to be created.
type IPRouteSpec struct {
	Name            string   `json:"name"`
	AdminDistance   int      `json:"adminDistance"`
	IPAddressPrefix string   `json:"ipAddressPrefix"`
	NextHopVnicSet  string   `json:"nextHopVnicSet"`
	Description     string   `json:"description"`
	Tags            []string `json:"tags"`
}

// IPRouteInfo describes an existing IP network.
type IPRouteInfo struct {
	Name            string   `json:"name"`
	AdminDistance   int      `json:"adminDistance"`
	IPAddressPrefix string   `json:"ipAddressPrefix"`
	NextHopVnicSet  string   `json:"nextHopVnicSet"`
	Description     string   `json:"description"`
	Tags            []string `json:"tags"`
	URI             string   `json:"uri"`
}

func (c *IPRoutesClient) success(result *IPRouteInfo) (*IPRouteInfo, error) {
	c.unqualify(&result.Name)
	return result, nil
}

// CreateIPRoute creates a new IP route.
func (c *IPRoutesClient) CreateIPRoute(name, description, ipAddressPrefix, nextHopVnicSet string, adminDistance int, tags []string) (*IPRouteInfo, error) {
	spec := IPRouteSpec{
		Name:            c.getQualifiedName(name),
		AdminDistance:   adminDistance,
		IPAddressPrefix: ipAddressPrefix,
		NextHopVnicSet:  c.getQualifiedName(nextHopVnicSet),
		Description:     description,
		Tags:            tags,
	}
	var ipInfo IPRouteInfo
	if err := c.createResource(&spec, &ipInfo); err != nil {
		return nil, err
	}

	return c.success(&ipInfo)
}

// GetIPRoute retrieves the IP route with the given name.
func (c *IPRoutesClient) GetIPRoute(name string) (*IPRouteInfo, error) {
	var ipInfo IPRouteInfo
	if err := c.getResource(name, &ipInfo); err != nil {
		return nil, err
	}

	ipInfo.NextHopVnicSet = c.getUnqualifiedName(ipInfo.NextHopVnicSet)

	return c.success(&ipInfo)
}

// UpdateIPRoute updates the ip network details.
func (c *IPRoutesClient) UpdateIPRoute(name, description, ipAddressPrefix, nextHopVnicSet string, adminDistance int, tags []string) (*IPRouteInfo, error) {
	spec := IPRouteSpec{
		Name:            c.getQualifiedName(name),
		AdminDistance:   adminDistance,
		IPAddressPrefix: ipAddressPrefix,
		NextHopVnicSet:  c.getQualifiedName(nextHopVnicSet),
		Description:     description,
		Tags:            tags,
	}

	var ipInfo IPRouteInfo
	if err := c.updateResource(name, &spec, &ipInfo); err != nil {
		return nil, err
	}

	return c.success(&ipInfo)
}

// DeleteIPRoute deletes the IP reservation with the given name.
func (c *IPRoutesClient) DeleteIPRoute(name string) error {
	return c.deleteResource(name)
}
