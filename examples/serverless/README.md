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
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 3.63 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 3.63 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_aurora_mysql"></a> [aurora\_mysql](#module\_aurora\_mysql) | ../../ | n/a |
| <a name="module_aurora_postgresql"></a> [aurora\_postgresql](#module\_aurora\_postgresql) | ../../ | n/a |
| <a name="module_vpc"></a> [vpc](#module\_vpc) | terraform-aws-modules/vpc/aws | ~> 3.0 |

## Resources

| Name | Type |
|------|------|
| [aws_db_parameter_group.example_mysql](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_parameter_group) | resource |
| [aws_db_parameter_group.example_postgresql](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_parameter_group) | resource |
| [aws_rds_cluster_parameter_group.example_mysql](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/rds_cluster_parameter_group) | resource |
| [aws_rds_cluster_parameter_group.example_postgresql](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/rds_cluster_parameter_group) | resource |

## Inputs

No inputs.

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_enhanced_monitoring_iam_role_arn"></a> [enhanced\_monitoring\_iam\_role\_arn](#output\_enhanced\_monitoring\_iam\_role\_arn) | The Amazon Resource Name (ARN) specifying the enhanced monitoring role |
| <a name="output_enhanced_monitoring_iam_role_name"></a> [enhanced\_monitoring\_iam\_role\_name](#output\_enhanced\_monitoring\_iam\_role\_name) | The name of the enhanced monitoring role |
| <a name="output_enhanced_monitoring_iam_role_unique_id"></a> [enhanced\_monitoring\_iam\_role\_unique\_id](#output\_enhanced\_monitoring\_iam\_role\_unique\_id) | Stable and unique string identifying the enhanced monitoring role |
| <a name="output_mysql_enhanced_monitoring_iam_role_arn"></a> [mysql\_enhanced\_monitoring\_iam\_role\_arn](#output\_mysql\_enhanced\_monitoring\_iam\_role\_arn) | The Amazon Resource Name (ARN) specifying the enhanced monitoring role |
| <a name="output_mysql_enhanced_monitoring_iam_role_name"></a> [mysql\_enhanced\_monitoring\_iam\_role\_name](#output\_mysql\_enhanced\_monitoring\_iam\_role\_name) | The name of the enhanced monitoring role |
| <a name="output_mysql_enhanced_monitoring_iam_role_unique_id"></a> [mysql\_enhanced\_monitoring\_iam\_role\_unique\_id](#output\_mysql\_enhanced\_monitoring\_iam\_role\_unique\_id) | Stable and unique string identifying the enhanced monitoring role |
| <a name="output_mysql_rds_cluster_database_name"></a> [mysql\_rds\_cluster\_database\_name](#output\_mysql\_rds\_cluster\_database\_name) | Name for an automatically created database on cluster creation |
| <a name="output_mysql_rds_cluster_endpoint"></a> [mysql\_rds\_cluster\_endpoint](#output\_mysql\_rds\_cluster\_endpoint) | The cluster endpoint |
| <a name="output_mysql_rds_cluster_id"></a> [mysql\_rds\_cluster\_id](#output\_mysql\_rds\_cluster\_id) | The ID of the cluster |
| <a name="output_mysql_rds_cluster_instances"></a> [mysql\_rds\_cluster\_instances](#output\_mysql\_rds\_cluster\_instances) | A map of cluster instances and their attributes |
| <a name="output_mysql_rds_cluster_master_password"></a> [mysql\_rds\_cluster\_master\_password](#output\_mysql\_rds\_cluster\_master\_password) | The master password |
| <a name="output_mysql_rds_cluster_master_username"></a> [mysql\_rds\_cluster\_master\_username](#output\_mysql\_rds\_cluster\_master\_username) | The master username |
| <a name="output_mysql_rds_cluster_port"></a> [mysql\_rds\_cluster\_port](#output\_mysql\_rds\_cluster\_port) | The port |
| <a name="output_mysql_rds_cluster_reader_endpoint"></a> [mysql\_rds\_cluster\_reader\_endpoint](#output\_mysql\_rds\_cluster\_reader\_endpoint) | The cluster reader endpoint |
| <a name="output_mysql_rds_cluster_resource_id"></a> [mysql\_rds\_cluster\_resource\_id](#output\_mysql\_rds\_cluster\_resource\_id) | The Resource ID of the cluster |
| <a name="output_mysql_security_group_id"></a> [mysql\_security\_group\_id](#output\_mysql\_security\_group\_id) | The security group ID of the cluster |
| <a name="output_postgresql_rds_cluster_database_name"></a> [postgresql\_rds\_cluster\_database\_name](#output\_postgresql\_rds\_cluster\_database\_name) | Name for an automatically created database on cluster creation |
| <a name="output_postgresql_rds_cluster_endpoint"></a> [postgresql\_rds\_cluster\_endpoint](#output\_postgresql\_rds\_cluster\_endpoint) | The cluster endpoint |
| <a name="output_postgresql_rds_cluster_id"></a> [postgresql\_rds\_cluster\_id](#output\_postgresql\_rds\_cluster\_id) | The ID of the cluster |
| <a name="output_postgresql_rds_cluster_instances"></a> [postgresql\_rds\_cluster\_instances](#output\_postgresql\_rds\_cluster\_instances) | A map of cluster instances and their attributes |
| <a name="output_postgresql_rds_cluster_master_password"></a> [postgresql\_rds\_cluster\_master\_password](#output\_postgresql\_rds\_cluster\_master\_password) | The master password |
| <a name="output_postgresql_rds_cluster_master_username"></a> [postgresql\_rds\_cluster\_master\_username](#output\_postgresql\_rds\_cluster\_master\_username) | The master username |
| <a name="output_postgresql_rds_cluster_port"></a> [postgresql\_rds\_cluster\_port](#output\_postgresql\_rds\_cluster\_port) | The port |
| <a name="output_postgresql_rds_cluster_reader_endpoint"></a> [postgresql\_rds\_cluster\_reader\_endpoint](#output\_postgresql\_rds\_cluster\_reader\_endpoint) | The cluster reader endpoint |
| <a name="output_postgresql_rds_cluster_resource_id"></a> [postgresql\_rds\_cluster\_resource\_id](#output\_postgresql\_rds\_cluster\_resource\_id) | The Resource ID of the cluster |
| <a name="output_security_group_id"></a> [security\_group\_id](#output\_security\_group\_id) | The security group ID of the cluster |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
