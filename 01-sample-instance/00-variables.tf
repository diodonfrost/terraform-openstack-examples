# Params file for variables

#### GLANCE
variable "image" {
  type    = string
  default = "Centos 8"
}

#### NEUTRON
variable "external_network" {
  type    = string
  default = "external-network"
}

# UUID of external gateway
variable "external_gateway" {
  type    = string
  default = "f67f0d72-0ddf-11e4-9d95-e1f29f417e2f"
}

variable "dns_ip" {
  type    = list(string)
  default = ["8.8.8.8", "8.8.8.4"]
}

#### VM parameters
variable "flavor_http" {
  type    = string
  default = "t2.medium"
}

variable "network_http" {
  type = map(string)
  default = {
    subnet_name = "subnet-http"
    cidr        = "192.168.1.0/24"
  }
}

