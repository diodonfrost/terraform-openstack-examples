#### NETWORK CONFIGURATION ####



# Router creation
resource "openstack_networking_router_v2" "router" {
  name                = "router"
  external_network_id = "${var.external_gateway}"
}

#### HTTP NETWORK ####

# Network creation
resource "openstack_networking_network_v2" "network_http" {
  name                = "${var.network_http["network_name"]}"
}

# Network configuration
resource "openstack_networking_subnet_v2" "subnet_http" {
  name                = "${var.network_http["subnet_name"]}"
  network_id          = "${openstack_networking_network_v2.network_http.id}"
  cidr                = "${var.network_http["cidr"]}"
  dns_nameservers     = "${var.dns_ip}"
}

# Router interface configuration
resource "openstack_networking_router_interface_v2" "router_interface_http" {
  router_id           = "${openstack_networking_router_v2.router.id}"
  subnet_id           = "${openstack_networking_subnet_v2.subnet_http.id}"
}

#### DB NETWORK ####

# Network creation
resource "openstack_networking_network_v2" "network_db" {
  name                = "${var.network_db["network_name"]}"
}

# Network configuration
resource "openstack_networking_subnet_v2" "subnet_db" {
  name                = "${var.network_db["subnet_name"]}"
  network_id          = "${openstack_networking_network_v2.network_db.id}"
  cidr                = "${var.network_db["cidr"]}"
  dns_nameservers     = "${var.dns_ip}"
}

# Router interface configuration
resource "openstack_networking_router_interface_v2" "router_interface_db" {
  router_id           = "${openstack_networking_router_v2.router.id}"
  subnet_id           = "${openstack_networking_subnet_v2.subnet_db.id}"
}
