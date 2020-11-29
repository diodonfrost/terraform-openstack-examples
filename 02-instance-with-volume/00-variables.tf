# Params file for variables

#### GLANCE
variable "image" {
  type    = string
  default = "Centos 7"
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

#### VM HTTP parameters ####
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

#### MAIN DISK SIZE FOR HTTP
variable "volume_http" {
  type    = number
  default = 10
}

#### VM DB parameters ####
variable "flavor_db" {
  type    = string
  default = "t2.medium"
}

#### ATTACHED VOLUME PARAMS
variable "volume_db" {
  type    = number
  default = 15
}

