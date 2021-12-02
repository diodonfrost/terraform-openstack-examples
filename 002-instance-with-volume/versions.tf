terraform {
required_version = ">= 0.14.0"
  required_providers {
    openstack = {
      source  = "terraform-provider-openstack/openstack"
      version = "~> 1.35.0"
    }
  }
}

#Configure the OpenStack Provider

provider "openstack" {
  user_domain_name = "suporte.binario.cloud"
  user_name   = "jsantos"
  password    = "@Canada1273"
  auth_url    = "https://identity.wse.zone/v3/"
  region      = "BR-SP-01"
}

