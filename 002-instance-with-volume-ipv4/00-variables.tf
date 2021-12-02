# Params file for variables

variable "os_password" {
  sensitive = true
}

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


variable "external_gateway_ipv4" {
  type    = string
  default = "4d1b36da-94e9-4acc-8d3e-c41f9fb6f11b"
}

variable "dns_ipv4" {
  type    = list(string)
  default = ["8.8.8.8", "8.8.4.4"]
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

variable "volume_http2" {
  type    = number
  default = 30
}

variable "volume_db01" {
  type    = number
  default = 30
}

