# Serverless Example

Configuration in this directory creates Aurora serverless clusters for both PostgreSQL and MySQL.

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
| aurora_mysql | ../../ |  |
| aurora_postgresql | ../../ |  |
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
| mysql\_rds\_cluster\_database\_name | Name for an automatically created database on cluster creation |
| mysql\_rds\_cluster\_endpoint | The cluster endpoint |
| mysql\_rds\_cluster\_id | The ID of the cluster |
| mysql\_rds\_cluster\_instance\_endpoints | A list of all cluster instance endpoints |
| mysql\_rds\_cluster\_instance\_ids | A list of all cluster instance ids |
| mysql\_rds\_cluster\_master\_password | The master password |
| mysql\_rds\_cluster\_master\_username | The master username |
| mysql\_rds\_cluster\_port | The port |
| mysql\_rds\_cluster\_reader\_endpoint | The cluster reader endpoint |
| mysql\_rds\_cluster\_resource\_id | The Resource ID of the cluster |
| mysql\_security\_group\_id | The security group ID of the cluster |
| postgresql\_rds\_cluster\_database\_name | Name for an automatically created database on cluster creation |
| postgresql\_rds\_cluster\_endpoint | The cluster endpoint |
| postgresql\_rds\_cluster\_id | The ID of the cluster |
| postgresql\_rds\_cluster\_instance\_endpoints | A list of all cluster instance endpoints |
| postgresql\_rds\_cluster\_instance\_ids | A list of all cluster instance ids |
| postgresql\_rds\_cluster\_master\_password | The master password |
| postgresql\_rds\_cluster\_master\_username | The master username |
| postgresql\_rds\_cluster\_port | The port |
| postgresql\_rds\_cluster\_reader\_endpoint | The cluster reader endpoint |
| postgresql\_rds\_cluster\_resource\_id | The Resource ID of the cluster |
| postgresql\_security\_group\_id | The security group ID of the cluster |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
