#### INSTANCE HTTP ####

# Get the uiid of image
data "openstack_images_image_v2" "ubuntu_current" {
  name        = var.image
  most_recent = true
}

# Create instance
#
resource "openstack_compute_instance_v2" "http" {
  name        = "http-instance"
  flavor_name = var.flavor_http
  key_pair    = openstack_compute_keypair_v2.user_key.name
  user_data   = file("scripts/first-boot.sh")
  
  network {
    port = openstack_networking_port_v2.http_int_v4.id
  }

 network {
    port = openstack_networking_port_v2.http_int_v6.id
  }

  # Install system in volume
  block_device {
    volume_size           = var.volume_http
    destination_type      = "volume"
    delete_on_termination = true
    source_type           = "image"
    uuid                  = data.openstack_images_image_v2.ubuntu_current.id
  }
}

# Create network port ipv4
resource "openstack_networking_port_v2" "http_int_v4" {
  name           = "port-instance-http"
  network_id     = openstack_networking_network_v2.network_v4.id
  admin_state_up = true
  security_group_ids = [
    openstack_compute_secgroup_v2.ssh.id,
    openstack_compute_secgroup_v2.http.id,
  ]
  fixed_ip {
    subnet_id = openstack_networking_subnet_v2.subnet_v4.id
  }
}

# Create network port ipv6
resource "openstack_networking_port_v2" "http_int_v6" {
  name           = "port-instance-httpv6"
  network_id     = openstack_networking_network_v2.network_v6.id
  admin_state_up = true
  security_group_ids = [
    openstack_compute_secgroup_v2.ssh.id,
    openstack_compute_secgroup_v2.http.id,
  ]
  fixed_ip {
    subnet_id = openstack_networking_subnet_v2.subnet_v6.id
  }
}
