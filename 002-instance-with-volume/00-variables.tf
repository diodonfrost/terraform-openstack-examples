# Params file for variables

###### GLANCE ######

variable "image" {
  type    = string
  default = "BC-Ubuntu-20.04"
}

###### NEUTRON ######

variable "external_network" {
  type    = string
  default = "PUBLIC-IPv4"
}

### UUID of external gateway ###

# IPv4

variable "external_gateway_ipv4" {
  type    = string
  default = "4d1b36da-94e9-4acc-8d3e-c41f9fb6f11b"
}

variable "dns_ipv4" {
  type    = list(string)
  default = ["8.8.8.8", "8.8.4.4"]
}

# IPv6

variable "external_gateway_ipv6" {
  type    = string
  default = "d60a0dd1-0ead-47b8-9d0c-d40a9710151c"
}

variable "dns_ipv6" {
  type    = list(string)
  default = ["2001:4860:4860::8888", "2001:4860:4860::8844"]
}


###### VM HTTP parameters ######

variable "flavor_http" {
  type    = string
  default = "bc1-basic-1-2"
}

variable "network_v4" {
  type = map(string)
  default = {
    subnet_name = "subnet-v4"
    cidr        = "192.168.1.0/24"
  }
}

variable "network_v6" {
  type = map(string)
  default = {
    subnet_name = "subnet-v6"
    ip_version  = "6"
    subnetpool_id = "ac275b0a-04af-4426-be4a-4e7f89e633f7"
    ipv6_address_mode = "dhcpv6-stateful"
    ipv6_ra_mode = "dhcpv6-stateful"
  }
}


###### MAIN DISK SIZE FOR HTTP ######

variable "volume_http" {
  type    = number
  default = 30
}

### VM DB parameters ###

variable "flavor_db" {
  type    = string
  default = "bc1-basic-2-4"
}

### ATTACHED VOLUME PARAMS ###

variable "volume_db" {
  type    = number
  default = 30
}

variable "volume_db01" {
  type    = number
  default = 30
}

