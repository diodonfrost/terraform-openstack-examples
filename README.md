## Terraform introduction

Terraform is a tool for building, changing, and versioning infrastructure safely and efficiently. Terraform can manage existing and popular service providers as well as custom in-house solutions.

Version used:
*   Terraform 0.11.2

## Openstack authentification
The OpenStack provider is used to interact with the many resources supported by OpenStack. The provider needs to be configured with the proper credentials before it can be used.

```
provider "openstack" {
  user_name   = "my-litle-user"
  tenant_name = "my-little-tenant"
  password    = "secret"
  auth_url    = "http://your-cloud-prodivder.com"
}
```

## Getting Started

Before terraform apply you must download provider plugin:

```
terraform init
```

Display plan before apply manifest
```
terraform plan
```

Apply manifest
```
terraform apply
```

Destroy stack
```
terraform destroy
```

## Documentation
[https://www.terraform.io/docs/providers/openstack/](https://www.terraform.io/docs/providers/openstack/)

[https://github.com/terraform-providers/terraform-provider-openstack/tree/master/examples/app-with-networking](https://www.terraform.io/docs/providers/openstack/)
