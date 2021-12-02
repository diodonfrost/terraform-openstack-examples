#### NETWORK CONFIGURATION ####

# Router creation
resource "openstack_networking_router_v2" "router_v4" {
  name                = "router-v4"
  external_network_id = var.external_gateway_ipv4
}

# Network creation
resource "openstack_networking_network_v2" "network_v4" {
  name = "network-v4"
}

#### SUBNET ####

# Subnet http configuration
resource "openstack_networking_subnet_v2" "subnet_v4" {
  name            = var.network_v4["subnet_name"]
  network_id      = openstack_networking_network_v2.network_v4.id
  cidr            = var.network_v4["cidr"]
  dns_nameservers = var.dns_ipv4
}

# Router interface configuration
resource "openstack_networking_router_interface_v2" "int_router_v4" {
  router_id = openstack_networking_router_v2.router_v4.id
  subnet_id = openstack_networking_subnet_v2.subnet_v4.id
}

