#### INSTANCE DB ####

# Create instance
#
resource "openstack_compute_instance_v2" "instance_db" {
  count              = "${var.desired_capacity_db}"
  name               = "db-${count.index}"
  image_name         = "${var.image}"
  flavor_name        = "${var.flavor_db}"
  key_pair           = "${openstack_compute_keypair_v2.user_key.name}"
  user_data          = "${file("scripts/first-boot.sh")}"
  network {
    port             = "${element(openstack_networking_port_v2.port_instance_db.*.id, count.index)}"
  }
}

# Create network port
resource "openstack_networking_port_v2" "port_instance_db" {
  count              = "${var.desired_capacity_db}"
  name               = "port-db-${count.index}"
  network_id         = "${openstack_networking_network_v2.network_db.id}"
  admin_state_up     = true
  security_group_ids = ["${openstack_compute_secgroup_v2.security_group_ssh.id}",
                        "${openstack_compute_secgroup_v2.security_group_db.id}"]
  fixed_ip           = {
    subnet_id        = "${openstack_networking_subnet_v2.subnet_db.id}"
  }
}
