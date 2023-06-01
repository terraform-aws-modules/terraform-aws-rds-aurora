# Aurora Global Cluster Example

Configuration in this directory creates a PostgreSQL Aurora global cluster.

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
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.67 |
| <a name="requirement_random"></a> [random](#requirement\_random) | >= 2.2 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 4.67 |
| <a name="provider_aws.secondary"></a> [aws.secondary](#provider\_aws.secondary) | >= 4.67 |
| <a name="provider_random"></a> [random](#provider\_random) | >= 2.2 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_aurora_primary"></a> [aurora\_primary](#module\_aurora\_primary) | ../../ | n/a |
| <a name="module_aurora_secondary"></a> [aurora\_secondary](#module\_aurora\_secondary) | ../../ | n/a |
| <a name="module_primary_vpc"></a> [primary\_vpc](#module\_primary\_vpc) | terraform-aws-modules/vpc/aws | ~> 5.0 |
| <a name="module_secondary_vpc"></a> [secondary\_vpc](#module\_secondary\_vpc) | terraform-aws-modules/vpc/aws | ~> 5.0 |

## Resources

| Name | Type |
|------|------|
| [aws_kms_key.primary](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key) | resource |
| [aws_kms_key.secondary](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key) | resource |
| [aws_rds_global_cluster.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/rds_global_cluster) | resource |
| [random_password.master](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [aws_availability_zones.primary](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/availability_zones) | data source |
| [aws_availability_zones.secondary](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/availability_zones) | data source |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.rds](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

No inputs.

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_primary_additional_cluster_endpoints"></a> [primary\_additional\_cluster\_endpoints](#output\_primary\_additional\_cluster\_endpoints) | A map of additional cluster endpoints and their attributes |
| <a name="output_primary_cluster_arn"></a> [primary\_cluster\_arn](#output\_primary\_cluster\_arn) | Amazon Resource Name (ARN) of cluster |
| <a name="output_primary_cluster_database_name"></a> [primary\_cluster\_database\_name](#output\_primary\_cluster\_database\_name) | Name for an automatically created database on cluster creation |
| <a name="output_primary_cluster_endpoint"></a> [primary\_cluster\_endpoint](#output\_primary\_cluster\_endpoint) | Writer endpoint for the cluster |
| <a name="output_primary_cluster_engine_version_actual"></a> [primary\_cluster\_engine\_version\_actual](#output\_primary\_cluster\_engine\_version\_actual) | The running version of the cluster database |
| <a name="output_primary_cluster_hosted_zone_id"></a> [primary\_cluster\_hosted\_zone\_id](#output\_primary\_cluster\_hosted\_zone\_id) | The Route53 Hosted Zone ID of the endpoint |
| <a name="output_primary_cluster_id"></a> [primary\_cluster\_id](#output\_primary\_cluster\_id) | The RDS Cluster Identifier |
| <a name="output_primary_cluster_instances"></a> [primary\_cluster\_instances](#output\_primary\_cluster\_instances) | A map of cluster instances and their attributes |
| <a name="output_primary_cluster_master_user_secret"></a> [primary\_cluster\_master\_user\_secret](#output\_primary\_cluster\_master\_user\_secret) | The generated database master user secret when `manage_master_user_password` is set to `true` |
| <a name="output_primary_cluster_members"></a> [primary\_cluster\_members](#output\_primary\_cluster\_members) | List of RDS Instances that are a part of this cluster |
| <a name="output_primary_cluster_port"></a> [primary\_cluster\_port](#output\_primary\_cluster\_port) | The database port |
| <a name="output_primary_cluster_reader_endpoint"></a> [primary\_cluster\_reader\_endpoint](#output\_primary\_cluster\_reader\_endpoint) | A read-only endpoint for the cluster, automatically load-balanced across replicas |
| <a name="output_primary_cluster_resource_id"></a> [primary\_cluster\_resource\_id](#output\_primary\_cluster\_resource\_id) | The RDS Cluster Resource ID |
| <a name="output_primary_cluster_role_associations"></a> [primary\_cluster\_role\_associations](#output\_primary\_cluster\_role\_associations) | A map of IAM roles associated with the cluster and their attributes |
| <a name="output_primary_db_cluster_cloudwatch_log_groups"></a> [primary\_db\_cluster\_cloudwatch\_log\_groups](#output\_primary\_db\_cluster\_cloudwatch\_log\_groups) | Map of CloudWatch log groups created and their attributes |
| <a name="output_primary_db_cluster_parameter_group_arn"></a> [primary\_db\_cluster\_parameter\_group\_arn](#output\_primary\_db\_cluster\_parameter\_group\_arn) | The ARN of the DB cluster parameter group created |
| <a name="output_primary_db_cluster_parameter_group_id"></a> [primary\_db\_cluster\_parameter\_group\_id](#output\_primary\_db\_cluster\_parameter\_group\_id) | The ID of the DB cluster parameter group created |
| <a name="output_primary_db_parameter_group_arn"></a> [primary\_db\_parameter\_group\_arn](#output\_primary\_db\_parameter\_group\_arn) | The ARN of the DB parameter group created |
| <a name="output_primary_db_parameter_group_id"></a> [primary\_db\_parameter\_group\_id](#output\_primary\_db\_parameter\_group\_id) | The ID of the DB parameter group created |
| <a name="output_primary_db_subnet_group_name"></a> [primary\_db\_subnet\_group\_name](#output\_primary\_db\_subnet\_group\_name) | The db subnet group name |
| <a name="output_primary_enhanced_monitoring_iam_role_arn"></a> [primary\_enhanced\_monitoring\_iam\_role\_arn](#output\_primary\_enhanced\_monitoring\_iam\_role\_arn) | The Amazon Resource Name (ARN) specifying the enhanced monitoring role |
| <a name="output_primary_enhanced_monitoring_iam_role_name"></a> [primary\_enhanced\_monitoring\_iam\_role\_name](#output\_primary\_enhanced\_monitoring\_iam\_role\_name) | The name of the enhanced monitoring role |
| <a name="output_primary_enhanced_monitoring_iam_role_unique_id"></a> [primary\_enhanced\_monitoring\_iam\_role\_unique\_id](#output\_primary\_enhanced\_monitoring\_iam\_role\_unique\_id) | Stable and unique string identifying the enhanced monitoring role |
| <a name="output_primary_security_group_id"></a> [primary\_security\_group\_id](#output\_primary\_security\_group\_id) | The security group ID of the cluster |
| <a name="output_secondary_additional_cluster_endpoints"></a> [secondary\_additional\_cluster\_endpoints](#output\_secondary\_additional\_cluster\_endpoints) | A map of additional cluster endpoints and their attributes |
| <a name="output_secondary_cluster_arn"></a> [secondary\_cluster\_arn](#output\_secondary\_cluster\_arn) | Amazon Resource Name (ARN) of cluster |
| <a name="output_secondary_cluster_database_name"></a> [secondary\_cluster\_database\_name](#output\_secondary\_cluster\_database\_name) | Name for an automatically created database on cluster creation |
| <a name="output_secondary_cluster_endpoint"></a> [secondary\_cluster\_endpoint](#output\_secondary\_cluster\_endpoint) | Writer endpoint for the cluster |
| <a name="output_secondary_cluster_engine_version_actual"></a> [secondary\_cluster\_engine\_version\_actual](#output\_secondary\_cluster\_engine\_version\_actual) | The running version of the cluster database |
| <a name="output_secondary_cluster_hosted_zone_id"></a> [secondary\_cluster\_hosted\_zone\_id](#output\_secondary\_cluster\_hosted\_zone\_id) | The Route53 Hosted Zone ID of the endpoint |
| <a name="output_secondary_cluster_id"></a> [secondary\_cluster\_id](#output\_secondary\_cluster\_id) | The RDS Cluster Identifier |
| <a name="output_secondary_cluster_instances"></a> [secondary\_cluster\_instances](#output\_secondary\_cluster\_instances) | A map of cluster instances and their attributes |
| <a name="output_secondary_cluster_master_user_secret"></a> [secondary\_cluster\_master\_user\_secret](#output\_secondary\_cluster\_master\_user\_secret) | The generated database master user secret when `manage_master_user_password` is set to `true` |
| <a name="output_secondary_cluster_members"></a> [secondary\_cluster\_members](#output\_secondary\_cluster\_members) | List of RDS Instances that are a part of this cluster |
| <a name="output_secondary_cluster_port"></a> [secondary\_cluster\_port](#output\_secondary\_cluster\_port) | The database port |
| <a name="output_secondary_cluster_reader_endpoint"></a> [secondary\_cluster\_reader\_endpoint](#output\_secondary\_cluster\_reader\_endpoint) | A read-only endpoint for the cluster, automatically load-balanced across replicas |
| <a name="output_secondary_cluster_resource_id"></a> [secondary\_cluster\_resource\_id](#output\_secondary\_cluster\_resource\_id) | The RDS Cluster Resource ID |
| <a name="output_secondary_cluster_role_associations"></a> [secondary\_cluster\_role\_associations](#output\_secondary\_cluster\_role\_associations) | A map of IAM roles associated with the cluster and their attributes |
| <a name="output_secondary_db_cluster_cloudwatch_log_groups"></a> [secondary\_db\_cluster\_cloudwatch\_log\_groups](#output\_secondary\_db\_cluster\_cloudwatch\_log\_groups) | Map of CloudWatch log groups created and their attributes |
| <a name="output_secondary_db_cluster_parameter_group_arn"></a> [secondary\_db\_cluster\_parameter\_group\_arn](#output\_secondary\_db\_cluster\_parameter\_group\_arn) | The ARN of the DB cluster parameter group created |
| <a name="output_secondary_db_cluster_parameter_group_id"></a> [secondary\_db\_cluster\_parameter\_group\_id](#output\_secondary\_db\_cluster\_parameter\_group\_id) | The ID of the DB cluster parameter group created |
| <a name="output_secondary_db_parameter_group_arn"></a> [secondary\_db\_parameter\_group\_arn](#output\_secondary\_db\_parameter\_group\_arn) | The ARN of the DB parameter group created |
| <a name="output_secondary_db_parameter_group_id"></a> [secondary\_db\_parameter\_group\_id](#output\_secondary\_db\_parameter\_group\_id) | The ID of the DB parameter group created |
| <a name="output_secondary_db_subnet_group_name"></a> [secondary\_db\_subnet\_group\_name](#output\_secondary\_db\_subnet\_group\_name) | The db subnet group name |
| <a name="output_secondary_enhanced_monitoring_iam_role_arn"></a> [secondary\_enhanced\_monitoring\_iam\_role\_arn](#output\_secondary\_enhanced\_monitoring\_iam\_role\_arn) | The Amazon Resource Name (ARN) specifying the enhanced monitoring role |
| <a name="output_secondary_enhanced_monitoring_iam_role_name"></a> [secondary\_enhanced\_monitoring\_iam\_role\_name](#output\_secondary\_enhanced\_monitoring\_iam\_role\_name) | The name of the enhanced monitoring role |
| <a name="output_secondary_enhanced_monitoring_iam_role_unique_id"></a> [secondary\_enhanced\_monitoring\_iam\_role\_unique\_id](#output\_secondary\_enhanced\_monitoring\_iam\_role\_unique\_id) | Stable and unique string identifying the enhanced monitoring role |
| <a name="output_secondary_security_group_id"></a> [secondary\_security\_group\_id](#output\_secondary\_security\_group\_id) | The security group ID of the cluster |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
