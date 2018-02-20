#### INSTANCE DB ####

# Create instance
#
resource "openstack_compute_instance_v2" "db" {
  name               = "front01"
  image_name         = "${var.image}"
  flavor_name        = "${var.flavor_db}"
  key_pair           = "${openstack_compute_keypair_v2.user_key.name}"
  user_data          = "${file("scripts/first-boot.sh")}"
  network {
    port             = "${openstack_networking_port_v2.db.id}"
  }
}

# Create network port
resource "openstack_networking_port_v2" "db" {
  name               = "port-instance-db"
  network_id         = "${openstack_networking_network_v2.generic.id}"
  admin_state_up     = true
  security_group_ids = ["${openstack_compute_secgroup_v2.ssh.id}",
                        "${openstack_compute_secgroup_v2.db.id}"]
  fixed_ip           = {
    subnet_id        = "${openstack_networking_subnet_v2.http.id}"
  }
}

# Create floating ip
resource "openstack_networking_floatingip_v2" "db" {
  pool               = "${var.external_network}"
}

# Attach floating ip to instance
resource "openstack_compute_floatingip_associate_v2" "db" {
  floating_ip        = "${openstack_networking_floatingip_v2.db.address}"
  instance_id        = "${openstack_compute_instance_v2.db.id}"
}

#### VOLUME MANAGEMENT ####

# Create volume
resource "openstack_blockstorage_volume_v2" "db" {
  name               = "volume-db"
  size               = "${var.volume_db}"
}

# Attach volume to instance instance db
resource "openstack_compute_volume_attach_v2" "db" {
  instance_id        = "${openstack_compute_instance_v2.db.id}"
  volume_id          = "${openstack_blockstorage_volume_v2.db.id}"
}
