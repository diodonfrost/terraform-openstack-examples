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

variable "http_instance_names" {
  type = set(string)
  default = ["http-instance-1",
    "http-instance-2",
  "http-instance-3"]
}

#### VM DB parameters ####
variable "flavor_db" {
  type    = string
  default = "t2.medium"
}

variable "network_db" {
  type = map(string)
  default = {
    subnet_name = "subnet-db"
    cidr        = "192.168.2.0/24"
  }
}

variable "db_instance_names" {
  type = set(string)
  default = ["db-instance-1",
    "db-instance-2",
  "db-instance-3"]
}

