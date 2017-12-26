#### INSTANCE HTTP ####

# Create instance
#
resource "openstack_compute_instance_v2" "instance_http" {
  name               = "front01"
  image_name         = "${var.image}"
  flavor_name        = "${var.flavor_http}"
  key_pair           = "${openstack_compute_keypair_v2.user_key.name}"
  user_data          = "${file("scripts/first-boot.sh")}"
  network {
    port             = "${openstack_networking_port_v2.port_instance_http.id}"
  }
}

# Create network port
resource "openstack_networking_port_v2" "port_instance_http" {
  name               = "port-instance-http"
  network_id         = "${openstack_networking_network_v2.network_http.id}"
  admin_state_up     = true
  security_group_ids = ["${openstack_compute_secgroup_v2.security_group_ssh.id}",
                        "${openstack_compute_secgroup_v2.security_group_http.id}"]
  fixed_ip           = {
    subnet_id        = "${openstack_networking_subnet_v2.subnet_http.id}"
  }
}

# Create floating ip
resource "openstack_networking_floatingip_v2" "floating_http" {
  pool               = "${var.external_network}"
}

# Attach floating ip to instance
resource "openstack_compute_floatingip_associate_v2" "floating_http" {
  floating_ip        = "${openstack_networking_floatingip_v2.floating_http.address}"
  instance_id        = "${openstack_compute_instance_v2.instance_http.id}"
}

#### VOLUME MANAGEMENT ####

# Create volume
resource "openstack_blockstorage_volume_v2" "volume_http" {
  name               = "volume-http"
  size               = "${var.volume_http}"
}

# Attach volume to instance server_db_two
resource "openstack_compute_volume_attach_v2" "volume_attachment" {
  instance_id        = "${openstack_compute_instance_v2.instance_http.id}"
  volume_id          = "${openstack_blockstorage_volume_v2.volume_http.id}"
}
