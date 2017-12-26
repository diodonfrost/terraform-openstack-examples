# Utilisation

![schéma d'infrastructure pool-with-multiple-network](img/pool-with-multiple-network.png "schéma d'infrastructure pool-with-multiple-network")

### Création de l'infrastructure

```
terraform apply
```

Ce script créera:
  - 1 routeur
  - 2 network
  - 2 instances http
  - 1 pool avec entre 1 et 3 instances

### Suppresion de l'infrastructure

```
terraform destroy
```
