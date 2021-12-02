# HTTP LOAD BALANCER CONFIGURATION
#
# Create loadbalancer
resource "openstack_lb_loadbalancer_v2" "http" {
  name          = "lb-teste"
  flavor_id     = "39790da9-7f3c-4038-ab3d-08a102c33f71"
  vip_subnet_id = openstack_networking_subnet_v2.subnet_v4.id
  depends_on    = [openstack_compute_instance_v2.http]
}

# Create listener
resource "openstack_lb_listener_v2" "http" {
  name                   = "listener_http"
  protocol               = "HTTP"
  protocol_port          = 8080
  timeout_client_data    = "50000"
  timeout_tcp_inspect    = "0"
  timeout_member_connect = "5000"
  timeout_member_data    = "50000"
  connection_limit       = "-1"
  loadbalancer_id        = openstack_lb_loadbalancer_v2.http.id
  depends_on             = [openstack_lb_loadbalancer_v2.http]
}

# Set methode for load balance charge between instance
resource "openstack_lb_pool_v2" "http" {
  name        = "pool_http"
  protocol    = "HTTP"
  lb_method   = "SOURCE_IP"
  listener_id = openstack_lb_listener_v2.http.id
  depends_on  = [openstack_lb_listener_v2.http]
}

# Add multip instances to pool
resource "openstack_lb_member_v2" "http" {
  address       = openstack_compute_instance_v2.http.access_ip_v4
  protocol_port = 80
  weight        = "10"
  pool_id       = openstack_lb_pool_v2.http.id
  subnet_id     = openstack_networking_subnet_v2.subnet_v4.id
  depends_on    = [openstack_lb_pool_v2.http]
}

resource "openstack_lb_member_v2" "http2" {
  address       = openstack_compute_instance_v2.http2.access_ip_v4
  protocol_port = 80
  pool_id       = openstack_lb_pool_v2.http.id
  subnet_id     = openstack_networking_subnet_v2.subnet_v4.id
  depends_on    = [openstack_lb_pool_v2.http]
}

# Create health monitor for check services instances status
resource "openstack_lb_monitor_v2" "http" {
  name        = "monitor_http"
  pool_id     = openstack_lb_pool_v2.http.id
  type        = "HTTP"
  max_retries_down = 3
  delay       = 5
  max_retries = 3
  timeout     = 5
  http_method = "GET"
  expected_codes = 200
  url_path    = "/"
  depends_on  = [openstack_lb_member_v2.http, openstack_lb_member_v2.http2]
}

# Create floating ip
 resource "openstack_networking_floatingip_v2" "http" {
   pool = var.external_network
}

# Attach floating ip to instance
 resource "openstack_networking_floatingip_associate_v2" "http" {
   floating_ip = openstack_networking_floatingip_v2.http.address
   port_id = openstack_lb_loadbalancer_v2.http.vip_port_id
}



# Show acesses LB
output "LoadBalancer_IP" {
  value = "http://${openstack_networking_floatingip_v2.http.address}:8080"
}



