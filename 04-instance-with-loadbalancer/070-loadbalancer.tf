# HTTP LOAD BALANCER CONFIGURATION
#
# Create loadbalancer
resource "openstack_lb_loadbalancer_v2" "elastic_loadbalancer_http" {
  name            = "elastic_loadbalancer_http"
  vip_subnet_id   = "${openstack_networking_subnet_v2.subnet_http.id}"
  depends_on      = [
    "openstack_compute_instance_v2.instance_http"
  ]
}

# Create listener
resource "openstack_lb_listener_v2" "listener_http" {
  name            = "listener_http"
  protocol        = "TCP"
  protocol_port   = 80
  loadbalancer_id = "${openstack_lb_loadbalancer_v2.elastic_loadbalancer_http.id}"
  depends_on      = [
      "openstack_lb_loadbalancer_v2.elastic_loadbalancer_http",
    ]
}

# Set methode for load balance charge between instance
resource "openstack_lb_pool_v2" "pool_http" {
  name            = "pool_http"
  protocol        = "TCP"
  lb_method       = "ROUND_ROBIN"
  listener_id     = "${openstack_lb_listener_v2.listener_http.id}"
  depends_on      = [
      "openstack_lb_listener_v2.listener_http",
    ]
}

# Add multip instances to pool
resource "openstack_lb_member_v2" "member_http" {
  count           = "${var.desired_capacity_http}"
  address         = "${element(openstack_compute_instance_v2.instance_http.*.access_ip_v4, count.index)}"
  protocol_port   = 80
  pool_id         = "${openstack_lb_pool_v2.pool_http.id}"
  subnet_id       = "${openstack_networking_subnet_v2.subnet_http.id}"
  depends_on      = [
      "openstack_lb_pool_v2.pool_http",
    ]
}

# Create health monitor for check services instances status
resource "openstack_lb_monitor_v2" "monitor_http" {
  name            = "monitor_http"
  pool_id         = "${openstack_lb_pool_v2.pool_http.id}"
  type            = "TCP"
  delay           = 2
  timeout         = 2
  max_retries     = 2
  depends_on      = [
      "openstack_lb_member_v2.member_http",
    ]
}

# DB LOAD BALANCER CONFIGURATION
#
# Create loadbalancer
resource "openstack_lb_loadbalancer_v2" "elastic_loadbalancer_db" {
  name            = "elastic_loadbalancer_db"
  vip_subnet_id   = "${openstack_networking_subnet_v2.subnet_db.id}"
  depends_on      = [
    "openstack_compute_instance_v2.instance_db"
  ]
}

# Create listener
resource "openstack_lb_listener_v2" "listener_db" {
  name            = "listener_db"
  protocol        = "TCP"
  protocol_port   = 3306
  loadbalancer_id = "${openstack_lb_loadbalancer_v2.elastic_loadbalancer_db.id}"
  depends_on      = [
      "openstack_lb_loadbalancer_v2.elastic_loadbalancer_db",
    ]
}

# Set methode for load balance charge between instance
resource "openstack_lb_pool_v2" "pool_db" {
  name            = "pool_db"
  protocol        = "TCP"
  lb_method       = "ROUND_ROBIN"
  listener_id     = "${openstack_lb_listener_v2.listener_db.id}"
  depends_on      = [
      "openstack_lb_listener_v2.listener_db",
    ]
}

# Add multip instances to pool
resource "openstack_lb_member_v2" "member_db" {
  count           = "${var.desired_capacity_db}"
  address         = "${element(openstack_compute_instance_v2.instance_db.*.access_ip_v4, count.index)}"
  protocol_port   = 3306
  pool_id         = "${openstack_lb_pool_v2.pool_db.id}"
  subnet_id       = "${openstack_networking_subnet_v2.subnet_db.id}"
  depends_on      = [
      "openstack_lb_pool_v2.pool_db",
    ]
}

# Create health monitor for check services instances status
resource "openstack_lb_monitor_v2" "monitor_db" {
  name            = "monitor_db"
  pool_id         = "${openstack_lb_pool_v2.pool_db.id}"
  type            = "TCP"
  delay           = 2
  timeout         = 2
  max_retries     = 2
  depends_on      = [
      "openstack_lb_member_v2.member_db",
    ]
}
