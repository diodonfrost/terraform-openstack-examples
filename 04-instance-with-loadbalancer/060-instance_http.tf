#### INSTANCE HTTP ####

# Create instance
#
resource "openstack_compute_instance_v2" "http" {
  for_each    = var.http_instance_names
  name        = each.key
  image_name  = var.image
  flavor_name = var.flavor_http
  key_pair    = openstack_compute_keypair_v2.user_key.name
  user_data   = file("scripts/first-boot.sh")
  network {
    port = openstack_networking_port_v2.http[each.key].id
  }
}

# Create network port
resource "openstack_networking_port_v2" "http" {
  for_each       = var.http_instance_names
  name           = "port-http-${each.key}"
  network_id     = openstack_networking_network_v2.generic.id
  admin_state_up = true
  security_group_ids = [
    openstack_compute_secgroup_v2.ssh.id,
    openstack_compute_secgroup_v2.http.id,
  ]
  fixed_ip {
    subnet_id = openstack_networking_subnet_v2.http.id
  }
}

