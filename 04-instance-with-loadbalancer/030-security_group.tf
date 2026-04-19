# Acces group, open input port 80
resource "openstack_networking_secgroup_v2" "http" {
  name        = "http"
  description = "Open input http port"
}

resource "openstack_networking_secgroup_rule_v2" "http" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 80
  port_range_max    = 80
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = openstack_networking_secgroup_v2.http.id
}

# Open mariadb port
resource "openstack_networking_secgroup_v2" "db" {
  name        = "db"
  description = "Open input db port"
}

resource "openstack_networking_secgroup_rule_v2" "db" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 3306
  port_range_max    = 3306
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = openstack_networking_secgroup_v2.db.id
}

# Open ssh port
resource "openstack_networking_secgroup_v2" "ssh" {
  name        = "ssh"
  description = "Open input ssh port"
}

resource "openstack_networking_secgroup_rule_v2" "ssh" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 22
  port_range_max    = 22
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = openstack_networking_secgroup_v2.ssh.id
}
