# MySQL Example

Configuration in this directory creates a MySQL Aurora cluster.

## Usage

To run this example you need to execute:

```bash
$ terraform init
$ terraform plan
$ terraform apply
```

Note that this example may create resources which cost money. Run `terraform destroy` when you don't need these resources.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.12.26 |
| aws | >= 3.8 |
| random | >= 2.2 |

## Providers

| Name | Version |
|------|---------|
| aws | >= 3.8 |
| random | >= 2.2 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| aurora | ../../ |  |
| vpc | terraform-aws-modules/vpc/aws | ~> 2 |

## Resources

| Name |
|------|
| [aws_db_parameter_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_parameter_group) |
| [aws_rds_cluster_parameter_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/rds_cluster_parameter_group) |
| [random_password](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) |

## Inputs

No input.

## Outputs

| Name | Description |
|------|-------------|
| this\_rds\_cluster\_database\_name | Name for an automatically created database on cluster creation |
| this\_rds\_cluster\_endpoint | The cluster endpoint |
| this\_rds\_cluster\_id | The ID of the cluster |
| this\_rds\_cluster\_instance\_endpoints | A list of all cluster instance endpoints |
| this\_rds\_cluster\_instance\_ids | A list of all cluster instance ids |
| this\_rds\_cluster\_master\_password | The master password |
| this\_rds\_cluster\_master\_username | The master username |
| this\_rds\_cluster\_port | The port |
| this\_rds\_cluster\_reader\_endpoint | The cluster reader endpoint |
| this\_rds\_cluster\_resource\_id | The Resource ID of the cluster |
| this\_security\_group\_id | The security group ID of the cluster |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
