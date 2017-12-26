# Configure credential OpenStack Provider
provider "openstack" {
  user_name   = "my-litle-user"
  tenant_name = "my-little-tenant"
  password    = "secret"
  auth_url    = "http://your-cloud-prodivder.com"
}

#### GLANCE
variable "image" {
  default = "centos-7"
}

#### NEUTRON
variable "external_network" {
  default = "external-network"
}

# UUID of external gateway
variable "external_gateway" {
  default = "f67f0d72-0ddf-11e4-9d95-e1f29f417e2f"
}

variable "dns_ip" {
  default = ["8.8.8.8", "8.8.8.4"]
}

#### VM parameters
variable "flavor_http" {
  default = "t2.medium"
}

variable "network_http" {
  default = {
    network_name = "network-http"
    subnet_name  = "subnet-http"
    cidr         = "192.168.1.0/24"
  }
}
