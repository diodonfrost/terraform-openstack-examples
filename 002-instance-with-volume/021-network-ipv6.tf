#### NETWORK CONFIGURATION ####

# Router creation
resource "openstack_networking_router_v2" "router_v6" {
  name                = "router-v6"
  external_network_id = var.external_gateway_ipv6
}

# Network creation
resource "openstack_networking_network_v2" "network_v6" {
  name = "network-v6"
}

#### SUBNET ####

# Subnet http configuration
resource "openstack_networking_subnet_v2" "subnet_v6" {
  name            = var.network_v6["subnet_name"]
  ip_version      = var.network_v6["ip_version"]
  network_id      = openstack_networking_network_v2.network_v6.id
  dns_nameservers = var.dns_ipv6
  ipv6_address_mode = var.network_v6["ipv6_address_mode"]
  ipv6_ra_mode = var.network_v6["ipv6_ra_mode"]
  subnetpool_id = var.network_v6["subnetpool_id"]
  
}

# Router interface configuration
resource "openstack_networking_router_interface_v2" "int_router_v6" {
  router_id = openstack_networking_router_v2.router_v6.id
  subnet_id = openstack_networking_subnet_v2.subnet_v6.id
}

