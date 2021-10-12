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
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 3.8 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 3.8 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_aurora_mysql"></a> [aurora\_mysql](#module\_aurora\_mysql) | ../../ |  |
| <a name="module_aurora_postgresql"></a> [aurora\_postgresql](#module\_aurora\_postgresql) | ../../ |  |
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
| <a name="output_mysql_rds_cluster_database_name"></a> [mysql\_rds\_cluster\_database\_name](#output\_mysql\_rds\_cluster\_database\_name) | Name for an automatically created database on cluster creation |
| <a name="output_mysql_rds_cluster_endpoint"></a> [mysql\_rds\_cluster\_endpoint](#output\_mysql\_rds\_cluster\_endpoint) | The cluster endpoint |
| <a name="output_mysql_rds_cluster_id"></a> [mysql\_rds\_cluster\_id](#output\_mysql\_rds\_cluster\_id) | The ID of the cluster |
| <a name="output_mysql_rds_cluster_instance_endpoints"></a> [mysql\_rds\_cluster\_instance\_endpoints](#output\_mysql\_rds\_cluster\_instance\_endpoints) | A list of all cluster instance endpoints |
| <a name="output_mysql_rds_cluster_instance_ids"></a> [mysql\_rds\_cluster\_instance\_ids](#output\_mysql\_rds\_cluster\_instance\_ids) | A list of all cluster instance ids |
| <a name="output_mysql_rds_cluster_master_password"></a> [mysql\_rds\_cluster\_master\_password](#output\_mysql\_rds\_cluster\_master\_password) | The master password |
| <a name="output_mysql_rds_cluster_master_username"></a> [mysql\_rds\_cluster\_master\_username](#output\_mysql\_rds\_cluster\_master\_username) | The master username |
| <a name="output_mysql_rds_cluster_port"></a> [mysql\_rds\_cluster\_port](#output\_mysql\_rds\_cluster\_port) | The port |
| <a name="output_mysql_rds_cluster_reader_endpoint"></a> [mysql\_rds\_cluster\_reader\_endpoint](#output\_mysql\_rds\_cluster\_reader\_endpoint) | The cluster reader endpoint |
| <a name="output_mysql_rds_cluster_resource_id"></a> [mysql\_rds\_cluster\_resource\_id](#output\_mysql\_rds\_cluster\_resource\_id) | The Resource ID of the cluster |
| <a name="output_mysql_security_group_id"></a> [mysql\_security\_group\_id](#output\_mysql\_security\_group\_id) | The security group ID of the cluster |
| <a name="output_postgresql_rds_cluster_database_name"></a> [postgresql\_rds\_cluster\_database\_name](#output\_postgresql\_rds\_cluster\_database\_name) | Name for an automatically created database on cluster creation |
| <a name="output_postgresql_rds_cluster_endpoint"></a> [postgresql\_rds\_cluster\_endpoint](#output\_postgresql\_rds\_cluster\_endpoint) | The cluster endpoint |
| <a name="output_postgresql_rds_cluster_id"></a> [postgresql\_rds\_cluster\_id](#output\_postgresql\_rds\_cluster\_id) | The ID of the cluster |
| <a name="output_postgresql_rds_cluster_instance_endpoints"></a> [postgresql\_rds\_cluster\_instance\_endpoints](#output\_postgresql\_rds\_cluster\_instance\_endpoints) | A list of all cluster instance endpoints |
| <a name="output_postgresql_rds_cluster_instance_ids"></a> [postgresql\_rds\_cluster\_instance\_ids](#output\_postgresql\_rds\_cluster\_instance\_ids) | A list of all cluster instance ids |
| <a name="output_postgresql_rds_cluster_master_password"></a> [postgresql\_rds\_cluster\_master\_password](#output\_postgresql\_rds\_cluster\_master\_password) | The master password |
| <a name="output_postgresql_rds_cluster_master_username"></a> [postgresql\_rds\_cluster\_master\_username](#output\_postgresql\_rds\_cluster\_master\_username) | The master username |
| <a name="output_postgresql_rds_cluster_port"></a> [postgresql\_rds\_cluster\_port](#output\_postgresql\_rds\_cluster\_port) | The port |
| <a name="output_postgresql_rds_cluster_reader_endpoint"></a> [postgresql\_rds\_cluster\_reader\_endpoint](#output\_postgresql\_rds\_cluster\_reader\_endpoint) | The cluster reader endpoint |
| <a name="output_postgresql_rds_cluster_resource_id"></a> [postgresql\_rds\_cluster\_resource\_id](#output\_postgresql\_rds\_cluster\_resource\_id) | The Resource ID of the cluster |
| <a name="output_postgresql_security_group_id"></a> [postgresql\_security\_group\_id](#output\_postgresql\_security\_group\_id) | The security group ID of the cluster |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
