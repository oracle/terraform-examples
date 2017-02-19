package compute

import (
	"net/http"
	"net/http/httptest"
	"net/url"
	"testing"
)

// Test that the client can create an instance.
func TestIPNetworksClient_CreateIPNetwork(t *testing.T) {
	server := newAuthenticatingServer(func(w http.ResponseWriter, r *http.Request) {
		if r.Method != "POST" {
			t.Errorf("Wrong HTTP method %s, expected POST", r.Method)
		}

		expectedPath := "/network/v1/ipnetwork/"
		if r.URL.Path != expectedPath {
			t.Errorf("Wrong HTTP URL %v, expected %v", r.URL, expectedPath)
		}

		listInfo := &IPNetworkSpec{}
		unmarshalRequestBody(t, r, listInfo)

		if listInfo.Name != "/Compute-test/test/test-ipnetwork1" {
			t.Errorf("Expected name 'test-ipnetwork1', was %s", listInfo.Name)
		}

		if listInfo.IPAddressPrefix != "192.168.1.0/24" {
			t.Errorf("Expected ip address prefix '192.168.1.0/24', was %s", listInfo.IPAddressPrefix)
		}

		w.Write([]byte(exampleCreateIPNetworkResponse))
		w.WriteHeader(201)
	})

	defer server.Close()
	client := getStubIPNetworkClient(server)
	info, err := client.CreateIPNetwork("test-ipnetwork1",  "192.168.1.0/24", "", "Test IP Network 1", nil)
	if err != nil {
		t.Fatalf("Create ip network request failed: %s", err)
	}

	if info.Name != "test-ipnetwork1" {
		t.Errorf("Expected ip network 'test-ipnetwork1, was %s", info.Name)
	}

	expected := "192.168.1.0/24"
	if info.IPAddressPrefix != expected {
		t.Errorf("Expected key %s, was %s", expected, info.IPAddressPrefix)
	}
}

func getStubIPNetworkClient(server *httptest.Server) *IPNetworksClient {
	endpoint, _ := url.Parse(server.URL)
	client := NewComputeClient("test", "test", "test", endpoint)
	authenticatedClient, _ := client.Authenticate()
	return authenticatedClient.IPNetworks()
}

var exampleCreateIPNetworkResponse = `
{
  "name": "/Compute-test/test/test-ipnetwork1",
  "uri": "https://api-z999.compute.us0.oraclecloud.com:443/network/v1/ipnetwork/Compute-test/test/test-ipnetwork1",
  "description": null,
  "tags": null,
  "ipAddressPrefix": "192.168.1.0/24",
  "ipNetworkExchange": null,
  "publicNaptEnabledFlag": false
}
`
