# Autoscaling Example

Configuration in this directory creates an Aurora cluster with autoscaling enabled.

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

## Providers

| Name | Version |
|------|---------|
| aws | >= 3.8 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| aurora | ../../ |  |
| disabled_aurora | ../../ |  |
| vpc | terraform-aws-modules/vpc/aws | ~> 2 |

## Resources

| Name |
|------|
| [aws_db_parameter_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_parameter_group) |
| [aws_rds_cluster_parameter_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/rds_cluster_parameter_group) |

## Inputs

No input.

## Outputs

| Name | Description |
|------|-------------|
| this\_enhanced\_monitoring\_iam\_role\_arn | The Amazon Resource Name (ARN) specifying the enhanced monitoring role |
| this\_enhanced\_monitoring\_iam\_role\_name | The name of the enhanced monitoring role |
| this\_enhanced\_monitoring\_iam\_role\_unique\_id | Stable and unique string identifying the enhanced monitoring role |
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
