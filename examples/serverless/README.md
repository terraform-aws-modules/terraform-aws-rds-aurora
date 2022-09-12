# Serverless Example

Configuration in this directory creates Aurora serverless clusters for both Serverless V1 (PostgreSQL, MySQL), and Serverless V2 (PostgreSQL).

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
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.30 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 4.30 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_aurora_mysql"></a> [aurora\_mysql](#module\_aurora\_mysql) | ../../ | n/a |
| <a name="module_aurora_mysql_v2"></a> [aurora\_mysql\_v2](#module\_aurora\_mysql\_v2) | ../../ | n/a |
| <a name="module_aurora_postgresql"></a> [aurora\_postgresql](#module\_aurora\_postgresql) | ../../ | n/a |
| <a name="module_aurora_postgresql_v2"></a> [aurora\_postgresql\_v2](#module\_aurora\_postgresql\_v2) | ../../ | n/a |
| <a name="module_vpc"></a> [vpc](#module\_vpc) | terraform-aws-modules/vpc/aws | ~> 3.0 |

## Resources

| Name | Type |
|------|------|
| [aws_db_parameter_group.example_mysql](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_parameter_group) | resource |
| [aws_db_parameter_group.example_mysql8](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_parameter_group) | resource |
| [aws_db_parameter_group.example_postgresql](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_parameter_group) | resource |
| [aws_db_parameter_group.example_postgresql13](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_parameter_group) | resource |
| [aws_rds_cluster_parameter_group.example_mysql](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/rds_cluster_parameter_group) | resource |
| [aws_rds_cluster_parameter_group.example_mysql8](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/rds_cluster_parameter_group) | resource |
| [aws_rds_cluster_parameter_group.example_postgresql](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/rds_cluster_parameter_group) | resource |
| [aws_rds_cluster_parameter_group.example_postgresql13](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/rds_cluster_parameter_group) | resource |
| [aws_rds_engine_version.postgresql](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/rds_engine_version) | data source |

## Inputs

No inputs.

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_aurora_mysql_v2_additional_cluster_endpoints"></a> [aurora\_mysql\_v2\_additional\_cluster\_endpoints](#output\_aurora\_mysql\_v2\_additional\_cluster\_endpoints) | A map of additional cluster endpoints and their attributes |
| <a name="output_aurora_mysql_v2_cluster_arn"></a> [aurora\_mysql\_v2\_cluster\_arn](#output\_aurora\_mysql\_v2\_cluster\_arn) | Amazon Resource Name (ARN) of cluster |
| <a name="output_aurora_mysql_v2_cluster_database_name"></a> [aurora\_mysql\_v2\_cluster\_database\_name](#output\_aurora\_mysql\_v2\_cluster\_database\_name) | Name for an automatically created database on cluster creation |
| <a name="output_aurora_mysql_v2_cluster_endpoint"></a> [aurora\_mysql\_v2\_cluster\_endpoint](#output\_aurora\_mysql\_v2\_cluster\_endpoint) | Writer endpoint for the cluster |
| <a name="output_aurora_mysql_v2_cluster_engine_version_actual"></a> [aurora\_mysql\_v2\_cluster\_engine\_version\_actual](#output\_aurora\_mysql\_v2\_cluster\_engine\_version\_actual) | The running version of the cluster database |
| <a name="output_aurora_mysql_v2_cluster_hosted_zone_id"></a> [aurora\_mysql\_v2\_cluster\_hosted\_zone\_id](#output\_aurora\_mysql\_v2\_cluster\_hosted\_zone\_id) | The Route53 Hosted Zone ID of the endpoint |
| <a name="output_aurora_mysql_v2_cluster_id"></a> [aurora\_mysql\_v2\_cluster\_id](#output\_aurora\_mysql\_v2\_cluster\_id) | The RDS Cluster Identifier |
| <a name="output_aurora_mysql_v2_cluster_instances"></a> [aurora\_mysql\_v2\_cluster\_instances](#output\_aurora\_mysql\_v2\_cluster\_instances) | A map of cluster instances and their attributes |
| <a name="output_aurora_mysql_v2_cluster_master_password"></a> [aurora\_mysql\_v2\_cluster\_master\_password](#output\_aurora\_mysql\_v2\_cluster\_master\_password) | The database master password |
| <a name="output_aurora_mysql_v2_cluster_master_username"></a> [aurora\_mysql\_v2\_cluster\_master\_username](#output\_aurora\_mysql\_v2\_cluster\_master\_username) | The database master username |
| <a name="output_aurora_mysql_v2_cluster_members"></a> [aurora\_mysql\_v2\_cluster\_members](#output\_aurora\_mysql\_v2\_cluster\_members) | List of RDS Instances that are a part of this cluster |
| <a name="output_aurora_mysql_v2_cluster_port"></a> [aurora\_mysql\_v2\_cluster\_port](#output\_aurora\_mysql\_v2\_cluster\_port) | The database port |
| <a name="output_aurora_mysql_v2_cluster_reader_endpoint"></a> [aurora\_mysql\_v2\_cluster\_reader\_endpoint](#output\_aurora\_mysql\_v2\_cluster\_reader\_endpoint) | A read-only endpoint for the cluster, automatically load-balanced across replicas |
| <a name="output_aurora_mysql_v2_cluster_resource_id"></a> [aurora\_mysql\_v2\_cluster\_resource\_id](#output\_aurora\_mysql\_v2\_cluster\_resource\_id) | The RDS Cluster Resource ID |
| <a name="output_aurora_mysql_v2_cluster_role_associations"></a> [aurora\_mysql\_v2\_cluster\_role\_associations](#output\_aurora\_mysql\_v2\_cluster\_role\_associations) | A map of IAM roles associated with the cluster and their attributes |
| <a name="output_aurora_mysql_v2_db_subnet_group_name"></a> [aurora\_mysql\_v2\_db\_subnet\_group\_name](#output\_aurora\_mysql\_v2\_db\_subnet\_group\_name) | The db subnet group name |
| <a name="output_aurora_mysql_v2_enhanced_monitoring_iam_role_arn"></a> [aurora\_mysql\_v2\_enhanced\_monitoring\_iam\_role\_arn](#output\_aurora\_mysql\_v2\_enhanced\_monitoring\_iam\_role\_arn) | The Amazon Resource Name (ARN) specifying the enhanced monitoring role |
| <a name="output_aurora_mysql_v2_enhanced_monitoring_iam_role_name"></a> [aurora\_mysql\_v2\_enhanced\_monitoring\_iam\_role\_name](#output\_aurora\_mysql\_v2\_enhanced\_monitoring\_iam\_role\_name) | The name of the enhanced monitoring role |
| <a name="output_aurora_mysql_v2_enhanced_monitoring_iam_role_unique_id"></a> [aurora\_mysql\_v2\_enhanced\_monitoring\_iam\_role\_unique\_id](#output\_aurora\_mysql\_v2\_enhanced\_monitoring\_iam\_role\_unique\_id) | Stable and unique string identifying the enhanced monitoring role |
| <a name="output_aurora_mysql_v2_security_group_id"></a> [aurora\_mysql\_v2\_security\_group\_id](#output\_aurora\_mysql\_v2\_security\_group\_id) | The security group ID of the cluster |
| <a name="output_aurora_postgresql_v2_additional_cluster_endpoints"></a> [aurora\_postgresql\_v2\_additional\_cluster\_endpoints](#output\_aurora\_postgresql\_v2\_additional\_cluster\_endpoints) | A map of additional cluster endpoints and their attributes |
| <a name="output_aurora_postgresql_v2_cluster_arn"></a> [aurora\_postgresql\_v2\_cluster\_arn](#output\_aurora\_postgresql\_v2\_cluster\_arn) | Amazon Resource Name (ARN) of cluster |
| <a name="output_aurora_postgresql_v2_cluster_database_name"></a> [aurora\_postgresql\_v2\_cluster\_database\_name](#output\_aurora\_postgresql\_v2\_cluster\_database\_name) | Name for an automatically created database on cluster creation |
| <a name="output_aurora_postgresql_v2_cluster_endpoint"></a> [aurora\_postgresql\_v2\_cluster\_endpoint](#output\_aurora\_postgresql\_v2\_cluster\_endpoint) | Writer endpoint for the cluster |
| <a name="output_aurora_postgresql_v2_cluster_engine_version_actual"></a> [aurora\_postgresql\_v2\_cluster\_engine\_version\_actual](#output\_aurora\_postgresql\_v2\_cluster\_engine\_version\_actual) | The running version of the cluster database |
| <a name="output_aurora_postgresql_v2_cluster_hosted_zone_id"></a> [aurora\_postgresql\_v2\_cluster\_hosted\_zone\_id](#output\_aurora\_postgresql\_v2\_cluster\_hosted\_zone\_id) | The Route53 Hosted Zone ID of the endpoint |
| <a name="output_aurora_postgresql_v2_cluster_id"></a> [aurora\_postgresql\_v2\_cluster\_id](#output\_aurora\_postgresql\_v2\_cluster\_id) | The RDS Cluster Identifier |
| <a name="output_aurora_postgresql_v2_cluster_instances"></a> [aurora\_postgresql\_v2\_cluster\_instances](#output\_aurora\_postgresql\_v2\_cluster\_instances) | A map of cluster instances and their attributes |
| <a name="output_aurora_postgresql_v2_cluster_master_password"></a> [aurora\_postgresql\_v2\_cluster\_master\_password](#output\_aurora\_postgresql\_v2\_cluster\_master\_password) | The database master password |
| <a name="output_aurora_postgresql_v2_cluster_master_username"></a> [aurora\_postgresql\_v2\_cluster\_master\_username](#output\_aurora\_postgresql\_v2\_cluster\_master\_username) | The database master username |
| <a name="output_aurora_postgresql_v2_cluster_members"></a> [aurora\_postgresql\_v2\_cluster\_members](#output\_aurora\_postgresql\_v2\_cluster\_members) | List of RDS Instances that are a part of this cluster |
| <a name="output_aurora_postgresql_v2_cluster_port"></a> [aurora\_postgresql\_v2\_cluster\_port](#output\_aurora\_postgresql\_v2\_cluster\_port) | The database port |
| <a name="output_aurora_postgresql_v2_cluster_reader_endpoint"></a> [aurora\_postgresql\_v2\_cluster\_reader\_endpoint](#output\_aurora\_postgresql\_v2\_cluster\_reader\_endpoint) | A read-only endpoint for the cluster, automatically load-balanced across replicas |
| <a name="output_aurora_postgresql_v2_cluster_resource_id"></a> [aurora\_postgresql\_v2\_cluster\_resource\_id](#output\_aurora\_postgresql\_v2\_cluster\_resource\_id) | The RDS Cluster Resource ID |
| <a name="output_aurora_postgresql_v2_cluster_role_associations"></a> [aurora\_postgresql\_v2\_cluster\_role\_associations](#output\_aurora\_postgresql\_v2\_cluster\_role\_associations) | A map of IAM roles associated with the cluster and their attributes |
| <a name="output_aurora_postgresql_v2_db_subnet_group_name"></a> [aurora\_postgresql\_v2\_db\_subnet\_group\_name](#output\_aurora\_postgresql\_v2\_db\_subnet\_group\_name) | The db subnet group name |
| <a name="output_aurora_postgresql_v2_enhanced_monitoring_iam_role_arn"></a> [aurora\_postgresql\_v2\_enhanced\_monitoring\_iam\_role\_arn](#output\_aurora\_postgresql\_v2\_enhanced\_monitoring\_iam\_role\_arn) | The Amazon Resource Name (ARN) specifying the enhanced monitoring role |
| <a name="output_aurora_postgresql_v2_enhanced_monitoring_iam_role_name"></a> [aurora\_postgresql\_v2\_enhanced\_monitoring\_iam\_role\_name](#output\_aurora\_postgresql\_v2\_enhanced\_monitoring\_iam\_role\_name) | The name of the enhanced monitoring role |
| <a name="output_aurora_postgresql_v2_enhanced_monitoring_iam_role_unique_id"></a> [aurora\_postgresql\_v2\_enhanced\_monitoring\_iam\_role\_unique\_id](#output\_aurora\_postgresql\_v2\_enhanced\_monitoring\_iam\_role\_unique\_id) | Stable and unique string identifying the enhanced monitoring role |
| <a name="output_aurora_postgresql_v2_security_group_id"></a> [aurora\_postgresql\_v2\_security\_group\_id](#output\_aurora\_postgresql\_v2\_security\_group\_id) | The security group ID of the cluster |
| <a name="output_mysql_additional_cluster_endpoints"></a> [mysql\_additional\_cluster\_endpoints](#output\_mysql\_additional\_cluster\_endpoints) | A map of additional cluster endpoints and their attributes |
| <a name="output_mysql_cluster_arn"></a> [mysql\_cluster\_arn](#output\_mysql\_cluster\_arn) | Amazon Resource Name (ARN) of cluster |
| <a name="output_mysql_cluster_database_name"></a> [mysql\_cluster\_database\_name](#output\_mysql\_cluster\_database\_name) | Name for an automatically created database on cluster creation |
| <a name="output_mysql_cluster_endpoint"></a> [mysql\_cluster\_endpoint](#output\_mysql\_cluster\_endpoint) | Writer endpoint for the cluster |
| <a name="output_mysql_cluster_engine_version_actual"></a> [mysql\_cluster\_engine\_version\_actual](#output\_mysql\_cluster\_engine\_version\_actual) | The running version of the cluster database |
| <a name="output_mysql_cluster_hosted_zone_id"></a> [mysql\_cluster\_hosted\_zone\_id](#output\_mysql\_cluster\_hosted\_zone\_id) | The Route53 Hosted Zone ID of the endpoint |
| <a name="output_mysql_cluster_id"></a> [mysql\_cluster\_id](#output\_mysql\_cluster\_id) | The RDS Cluster Identifier |
| <a name="output_mysql_cluster_instances"></a> [mysql\_cluster\_instances](#output\_mysql\_cluster\_instances) | A map of cluster instances and their attributes |
| <a name="output_mysql_cluster_master_password"></a> [mysql\_cluster\_master\_password](#output\_mysql\_cluster\_master\_password) | The database master password |
| <a name="output_mysql_cluster_master_username"></a> [mysql\_cluster\_master\_username](#output\_mysql\_cluster\_master\_username) | The database master username |
| <a name="output_mysql_cluster_members"></a> [mysql\_cluster\_members](#output\_mysql\_cluster\_members) | List of RDS Instances that are a part of this cluster |
| <a name="output_mysql_cluster_port"></a> [mysql\_cluster\_port](#output\_mysql\_cluster\_port) | The database port |
| <a name="output_mysql_cluster_reader_endpoint"></a> [mysql\_cluster\_reader\_endpoint](#output\_mysql\_cluster\_reader\_endpoint) | A read-only endpoint for the cluster, automatically load-balanced across replicas |
| <a name="output_mysql_cluster_resource_id"></a> [mysql\_cluster\_resource\_id](#output\_mysql\_cluster\_resource\_id) | The RDS Cluster Resource ID |
| <a name="output_mysql_cluster_role_associations"></a> [mysql\_cluster\_role\_associations](#output\_mysql\_cluster\_role\_associations) | A map of IAM roles associated with the cluster and their attributes |
| <a name="output_mysql_db_subnet_group_name"></a> [mysql\_db\_subnet\_group\_name](#output\_mysql\_db\_subnet\_group\_name) | The db subnet group name |
| <a name="output_mysql_enhanced_monitoring_iam_role_arn"></a> [mysql\_enhanced\_monitoring\_iam\_role\_arn](#output\_mysql\_enhanced\_monitoring\_iam\_role\_arn) | The Amazon Resource Name (ARN) specifying the enhanced monitoring role |
| <a name="output_mysql_enhanced_monitoring_iam_role_name"></a> [mysql\_enhanced\_monitoring\_iam\_role\_name](#output\_mysql\_enhanced\_monitoring\_iam\_role\_name) | The name of the enhanced monitoring role |
| <a name="output_mysql_enhanced_monitoring_iam_role_unique_id"></a> [mysql\_enhanced\_monitoring\_iam\_role\_unique\_id](#output\_mysql\_enhanced\_monitoring\_iam\_role\_unique\_id) | Stable and unique string identifying the enhanced monitoring role |
| <a name="output_mysql_security_group_id"></a> [mysql\_security\_group\_id](#output\_mysql\_security\_group\_id) | The security group ID of the cluster |
| <a name="output_postgresql_additional_cluster_endpoints"></a> [postgresql\_additional\_cluster\_endpoints](#output\_postgresql\_additional\_cluster\_endpoints) | A map of additional cluster endpoints and their attributes |
| <a name="output_postgresql_cluster_arn"></a> [postgresql\_cluster\_arn](#output\_postgresql\_cluster\_arn) | Amazon Resource Name (ARN) of cluster |
| <a name="output_postgresql_cluster_database_name"></a> [postgresql\_cluster\_database\_name](#output\_postgresql\_cluster\_database\_name) | Name for an automatically created database on cluster creation |
| <a name="output_postgresql_cluster_endpoint"></a> [postgresql\_cluster\_endpoint](#output\_postgresql\_cluster\_endpoint) | Writer endpoint for the cluster |
| <a name="output_postgresql_cluster_engine_version_actual"></a> [postgresql\_cluster\_engine\_version\_actual](#output\_postgresql\_cluster\_engine\_version\_actual) | The running version of the cluster database |
| <a name="output_postgresql_cluster_hosted_zone_id"></a> [postgresql\_cluster\_hosted\_zone\_id](#output\_postgresql\_cluster\_hosted\_zone\_id) | The Route53 Hosted Zone ID of the endpoint |
| <a name="output_postgresql_cluster_id"></a> [postgresql\_cluster\_id](#output\_postgresql\_cluster\_id) | The RDS Cluster Identifier |
| <a name="output_postgresql_cluster_instances"></a> [postgresql\_cluster\_instances](#output\_postgresql\_cluster\_instances) | A map of cluster instances and their attributes |
| <a name="output_postgresql_cluster_master_password"></a> [postgresql\_cluster\_master\_password](#output\_postgresql\_cluster\_master\_password) | The database master password |
| <a name="output_postgresql_cluster_master_username"></a> [postgresql\_cluster\_master\_username](#output\_postgresql\_cluster\_master\_username) | The database master username |
| <a name="output_postgresql_cluster_members"></a> [postgresql\_cluster\_members](#output\_postgresql\_cluster\_members) | List of RDS Instances that are a part of this cluster |
| <a name="output_postgresql_cluster_port"></a> [postgresql\_cluster\_port](#output\_postgresql\_cluster\_port) | The database port |
| <a name="output_postgresql_cluster_reader_endpoint"></a> [postgresql\_cluster\_reader\_endpoint](#output\_postgresql\_cluster\_reader\_endpoint) | A read-only endpoint for the cluster, automatically load-balanced across replicas |
| <a name="output_postgresql_cluster_resource_id"></a> [postgresql\_cluster\_resource\_id](#output\_postgresql\_cluster\_resource\_id) | The RDS Cluster Resource ID |
| <a name="output_postgresql_cluster_role_associations"></a> [postgresql\_cluster\_role\_associations](#output\_postgresql\_cluster\_role\_associations) | A map of IAM roles associated with the cluster and their attributes |
| <a name="output_postgresql_db_subnet_group_name"></a> [postgresql\_db\_subnet\_group\_name](#output\_postgresql\_db\_subnet\_group\_name) | The db subnet group name |
| <a name="output_postgresql_enhanced_monitoring_iam_role_arn"></a> [postgresql\_enhanced\_monitoring\_iam\_role\_arn](#output\_postgresql\_enhanced\_monitoring\_iam\_role\_arn) | The Amazon Resource Name (ARN) specifying the enhanced monitoring role |
| <a name="output_postgresql_enhanced_monitoring_iam_role_name"></a> [postgresql\_enhanced\_monitoring\_iam\_role\_name](#output\_postgresql\_enhanced\_monitoring\_iam\_role\_name) | The name of the enhanced monitoring role |
| <a name="output_postgresql_enhanced_monitoring_iam_role_unique_id"></a> [postgresql\_enhanced\_monitoring\_iam\_role\_unique\_id](#output\_postgresql\_enhanced\_monitoring\_iam\_role\_unique\_id) | Stable and unique string identifying the enhanced monitoring role |
| <a name="output_postgresql_security_group_id"></a> [postgresql\_security\_group\_id](#output\_postgresql\_security\_group\_id) | The security group ID of the cluster |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
