# Params file for variables

#### GLANCE
variable "image" {
  type    = string
  default = "BC-Ubuntu-20.04"
}

#### NEUTRON
variable "external_network" {
  type    = string
  default = "PUBLIC-IPv4"
}

# UUID of external gateway
variable "external_gatewayv4" {
  type    = string
  default = "4d1b36da-94e9-4acc-8d3e-c41f9fb6f11b"
}

variable "external_gatewayv6" {
  type    = string
  default = "d60a0dd1-0ead-47b8-9d0c-d40a9710151c"
}

variable "dns_ipv6" {
  type    = list(string)
  default = ["2001:4860:4860::8888", "2001:4860:4860::8844"]
}

variable "dns_ipv4" {
  type    = list(string)
  default = ["8.8.8.8", "8.8.4.4"]
}


#### VM HTTP parameters ####
variable "flavor_http" {
  type    = string
  default = "bc1-basic-1-2"
}

variable "network_http" {
  type = map(string)
  default = {
    subnet_name = "subnet-http"
    cidr        = "192.168.1.0/24"
  }
}

variable "network_httpv6" {
  type = map(string)
  default = {
    subnet_name = "subnet-httpv6"
    cidr        = "2804:4574:bc:5::/64"
  }
}


#### MAIN DISK SIZE FOR HTTP
variable "volume_http" {
  type    = number
  default = 30
}

#### VM DB parameters ####
variable "flavor_db" {
  type    = string
  default = "bc1-basic-2-4"
}

#### ATTACHED VOLUME PARAMS
variable "volume_db" {
  type    = number
  default = 30
}

