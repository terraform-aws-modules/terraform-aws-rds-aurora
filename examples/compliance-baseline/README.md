# Compliance Baseline Example

Configuration in this directory stands up an **audit-ready Aurora PostgreSQL cluster in one apply**: a customer-managed KMS key, a Secrets Manager master password with managed rotation, pgAudit logging, Database Activity Streams, private subnets only, deletion protection, IAM database authentication, and encrypted CloudWatch log exports.

It is intended as a starting point for workloads with HIPAA, SOC 2, or PCI DSS obligations. It is an **example**, not a certified configuration. You are responsible for mapping these controls to your own compliance scope and consulting the AWS service documentation for current best practices.

## Controls

| Control | How it is configured | Resource / input | AWS documentation |
| ------- | -------------------- | ---------------- | ----------------- |
| Encryption at rest | Storage encrypted with a customer-managed KMS key (annual key rotation) | `aws_kms_key.aurora` + `storage_encrypted` / `kms_key_id` | [Encrypting Amazon Aurora resources](https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/Overview.Encryption.html) |
| Encryption in transit | SSL/TLS forced for all client connections | `rds.force_ssl = 1` cluster parameter | [Using SSL/TLS with Aurora PostgreSQL](https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/AuroraPostgreSQL.Security.html#AuroraPostgreSQL.Security.SSL) |
| Credentials and rotation | Master password generated and stored in Secrets Manager with scheduled automatic rotation | `manage_master_user_password` + `manage_master_user_password_rotation` + `master_user_password_rotation_automatically_after_days` | [Password management with Secrets Manager](https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/rds-secrets-manager.html) |
| Authentication | IAM database authentication enabled (short-lived tokens instead of static passwords) | `iam_database_authentication_enabled` | [IAM database authentication](https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/UsingWithRDS.IAMDBAuth.html) |
| Audit logging | pgAudit preloaded and configured, connections and disconnections logged | `shared_preload_libraries`, `pgaudit.log`, `log_connections`, `log_disconnections` cluster parameters | [Setting up pgAudit for Aurora PostgreSQL](https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/AuroraPostgreSQL.Auditing.html) |
| Activity streams | Database Activity Streams in async mode, encrypted with the CMK, with audit fields included | `cluster_activity_stream` | [Monitoring with Database Activity Streams](https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/DBActivityStreams.html) |
| Log export | Postgres logs exported to a CloudWatch log group encrypted with the CMK | `enabled_cloudwatch_logs_exports`, `create_cloudwatch_log_group`, `cloudwatch_log_group_kms_key_id` | [Publishing Aurora PostgreSQL logs to CloudWatch Logs](https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/AuroraPostgreSQL.CloudWatch.html) |
| Performance monitoring | Performance Insights enabled at the cluster and writer level, encrypted with the CMK | `cluster_performance_insights_enabled`, `cluster_performance_insights_kms_key_id`, per-instance `performance_insights_*` | [Monitoring with Performance Insights](https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/USER_PerfInsights.html) |
| Network isolation | Cluster placed in private database subnets only; ingress restricted to the VPC private subnet CIDRs | `db_subnet_group_name` + `security_group_ingress_rules` (no public subnets) | [Amazon VPC and Amazon Aurora](https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/USER_VPC.html) |
| Deletion protection | Cluster cannot be deleted while enabled | `deletion_protection` | [Deletion protection for an Aurora cluster](https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/USER_DeleteCluster.html) |
| Backups and retention | Enhanced Monitoring on the writer; backups retained per module defaults (tune `backup_retention_period`) | per-instance `monitoring_interval`, module `backup_retention_period` | [Backing up and restoring an Aurora cluster](https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/BackupRestoreAurora.html) |

## Reusable inputs

The example is reusable as-is through four variables:

- `kms_key_arn` - bring your own CMK; defaults to a key created by the example.
- `master_user_password_rotation_days` - rotation cadence (default 90).
- `pgaudit_log_classes` - pgAudit statement classes (default `ddl,role,write`).
- `activity_stream_mode` - `async` (default) or `sync`.

## Usage

To run this example you need to execute:

```bash
$ terraform init
$ terraform plan
$ terraform apply
```

Note that this example creates resources which cost money (a provisioned `db.r6g.large` writer, Performance Insights, an activity stream). The cluster enables `deletion_protection`, so before `terraform destroy` you must disable it (set `deletion_protection = false` and apply, or disable it in the console).

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
| ---- | ------- |
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.11.1 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 6.61 |

## Providers

| Name | Version |
| ---- | ------- |
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 6.61 |

## Modules

| Name | Source | Version |
| ---- | ------ | ------- |
| <a name="module_aurora"></a> [aurora](#module\_aurora) | ../../ | n/a |
| <a name="module_vpc"></a> [vpc](#module\_vpc) | terraform-aws-modules/vpc/aws | ~> 6.0 |

## Resources

| Name | Type |
| ---- | ---- |
| [aws_kms_alias.aurora](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_alias) | resource |
| [aws_kms_key.aurora](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key) | resource |
| [aws_availability_zones.available](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/availability_zones) | data source |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.kms](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_partition.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/partition) | data source |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_activity_stream_mode"></a> [activity\_stream\_mode](#input\_activity\_stream\_mode) | Mode for Database Activity Streams. Valid values: `async`, `sync` | `string` | `"async"` | no |
| <a name="input_kms_key_arn"></a> [kms\_key\_arn](#input\_kms\_key\_arn) | ARN of an existing customer-managed KMS key to use for storage, Performance Insights, CloudWatch logs, and the activity stream. When empty, the example creates a dedicated CMK with rotation enabled | `string` | `""` | no |
| <a name="input_master_user_password_rotation_days"></a> [master\_user\_password\_rotation\_days](#input\_master\_user\_password\_rotation\_days) | Number of days between automatic rotations of the Secrets Manager master user password | `number` | `90` | no |
| <a name="input_pgaudit_log_classes"></a> [pgaudit\_log\_classes](#input\_pgaudit\_log\_classes) | Comma-separated pgAudit statement classes to log via the `pgaudit.log` cluster parameter (e.g. `ddl,role,write`) | `string` | `"ddl,role,write"` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_cluster_arn"></a> [cluster\_arn](#output\_cluster\_arn) | Amazon Resource Name (ARN) of cluster |
| <a name="output_cluster_endpoint"></a> [cluster\_endpoint](#output\_cluster\_endpoint) | Writer endpoint for the cluster |
| <a name="output_cluster_id"></a> [cluster\_id](#output\_cluster\_id) | The RDS Cluster Identifier |
| <a name="output_cluster_instances"></a> [cluster\_instances](#output\_cluster\_instances) | A map of cluster instances and their attributes |
| <a name="output_cluster_master_user_secret"></a> [cluster\_master\_user\_secret](#output\_cluster\_master\_user\_secret) | The generated database master user secret when `manage_master_user_password` is set to `true` |
| <a name="output_cluster_reader_endpoint"></a> [cluster\_reader\_endpoint](#output\_cluster\_reader\_endpoint) | A read-only endpoint for the cluster, automatically load-balanced across replicas |
| <a name="output_db_cluster_activity_stream_kinesis_stream_name"></a> [db\_cluster\_activity\_stream\_kinesis\_stream\_name](#output\_db\_cluster\_activity\_stream\_kinesis\_stream\_name) | The name of the Amazon Kinesis data stream to be used for the database activity stream |
| <a name="output_db_cluster_cloudwatch_log_groups"></a> [db\_cluster\_cloudwatch\_log\_groups](#output\_db\_cluster\_cloudwatch\_log\_groups) | Map of CloudWatch log groups created and their attributes |
| <a name="output_kms_key_arn"></a> [kms\_key\_arn](#output\_kms\_key\_arn) | ARN of the KMS key protecting the cluster, logs, Performance Insights, and activity stream |
| <a name="output_security_group_id"></a> [security\_group\_id](#output\_security\_group\_id) | The security group ID of the cluster |
<!-- END_TF_DOCS -->
