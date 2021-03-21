# AWS RDS Aurora Terraform module

Terraform module which creates RDS Aurora resources on AWS.

These types of resources are supported:

- [RDS Cluster](https://www.terraform.io/docs/providers/aws/r/rds_cluster.html)
- [RDS Cluster Instance](https://www.terraform.io/docs/providers/aws/r/rds_cluster_instance.html)
- [DB Subnet Group](https://www.terraform.io/docs/providers/aws/r/db_subnet_group.html)
- [Application AutoScaling Policy](https://www.terraform.io/docs/providers/aws/r/appautoscaling_policy.html)
- [Application AutoScaling Target](https://www.terraform.io/docs/providers/aws/r/appautoscaling_target.html)

## Available features

- Autoscaling of read-replicas (based on CPU utilization)
- Enhanced Monitoring

## Usage

```hcl
module "db" {
  source  = "terraform-aws-modules/rds-aurora/aws"
  version = "~> 3.0"

  name           = "test-aurora-db-postgres96"
  engine         = "aurora-postgresql"
  engine_version = "11.9"
  instance_type  = "db.r5.large"

  vpc_id  = "vpc-12345678"
  subnets = ["subnet-12345678", "subnet-87654321"]

  replica_count           = 1
  allowed_security_groups = ["sg-12345678"]
  allowed_cidr_blocks     = ["10.20.0.0/20"]

  storage_encrypted   = true
  apply_immediately   = true
  monitoring_interval = 10

  db_parameter_group_name         = "default"
  db_cluster_parameter_group_name = "default"

  enabled_cloudwatch_logs_exports = ["postgresql"]

  tags = {
    Environment = "dev"
    Terraform   = "true"
  }
}
```

## Conditional creation

Sometimes you need to have a way to create RDS Aurora resources conditionally but Terraform does not allow to use `count` inside `module` block, so the solution is to specify argument `create_cluster`.

```hcl
# This RDS cluster will not be created
module "db" {
  source  = "terraform-aws-modules/rds-aurora/aws"
  version = "~> 3.0"

  create_cluster = false
  # ... omitted
}
```

## Examples

- [Autoscaling](examples/autoscaling): A PostgreSQL cluster with enhanced monitoring and autoscaling enabled
- [Custom Instance Settings](examples/custom_instance_settings): A PostgreSQL cluster with multiple replics configured using custom settings
- [MySQL](examples/mysql): A simple MySQL cluster
- [PostgreSQL](examples/postgresql): A simple PostgreSQL cluster
- [S3 Import](examples/s3_import): A MySQL cluster created from a Percona Xtrabackup stored in S3
- [Serverless](examples/serverless): Serverless PostgreSQL and MySQL clusters

## Documentation

Terraform documentation is generated automatically using [pre-commit hooks](http://www.pre-commit.com/). Follow installation instructions [here](https://pre-commit.com/#install).

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.12.26 |
| aws | >= 3.30 |
| random | >= 2.2 |

## Providers

| Name | Version |
|------|---------|
| aws | >= 3.30 |
| random | >= 2.2 |

## Modules

No Modules.

## Resources

| Name |
|------|
| [aws_appautoscaling_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/appautoscaling_policy) |
| [aws_appautoscaling_target](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/appautoscaling_target) |
| [aws_db_subnet_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_subnet_group) |
| [aws_iam_policy_document](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) |
| [aws_iam_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) |
| [aws_iam_role_policy_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) |
| [aws_partition](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/partition) |
| [aws_rds_cluster](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/rds_cluster) |
| [aws_rds_cluster_instance](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/rds_cluster_instance) |
| [aws_security_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) |
| [aws_security_group_rule](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) |
| [random_id](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id) |
| [random_password](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| allow\_major\_version\_upgrade | Determines whether major engine upgrades are allowed when changing engine version | `bool` | `false` | no |
| allowed\_cidr\_blocks | A list of CIDR blocks which are allowed to access the database | `list(string)` | `[]` | no |
| allowed\_security\_groups | A list of Security Group ID's to allow access to | `list(string)` | `[]` | no |
| apply\_immediately | Determines whether or not any DB modifications are applied immediately, or during the maintenance window | `bool` | `false` | no |
| auto\_minor\_version\_upgrade | Determines whether minor engine upgrades will be performed automatically in the maintenance window | `bool` | `true` | no |
| backtrack\_window | The target backtrack window, in seconds. Only available for aurora engine currently. To disable backtracking, set this value to 0. Must be between 0 and 259200 (72 hours) | `number` | `0` | no |
| backup\_retention\_period | How long to keep backups for (in days) | `number` | `7` | no |
| ca\_cert\_identifier | The identifier of the CA certificate for the DB instance | `string` | `"rds-ca-2019"` | no |
| cluster\_tags | A map of tags to add to only the RDS cluster. Used for AWS Instance Scheduler tagging | `map(string)` | `{}` | no |
| copy\_tags\_to\_snapshot | Copy all Cluster tags to snapshots | `bool` | `false` | no |
| create\_cluster | Whether cluster should be created (it affects almost all resources) | `bool` | `true` | no |
| create\_monitoring\_role | Whether to create the IAM role for RDS enhanced monitoring | `bool` | `true` | no |
| create\_random\_password | Whether to create random password for RDS primary cluster | `bool` | `true` | no |
| create\_security\_group | Whether to create security group for RDS cluster | `bool` | `true` | no |
| database\_name | Name for an automatically created database on cluster creation | `string` | `""` | no |
| db\_cluster\_parameter\_group\_name | The name of a DB Cluster parameter group to use | `string` | `null` | no |
| db\_parameter\_group\_name | The name of a DB parameter group to use | `string` | `null` | no |
| db\_subnet\_group\_name | The existing subnet group name to use | `string` | `""` | no |
| deletion\_protection | If the DB instance should have deletion protection enabled | `bool` | `false` | no |
| enable\_http\_endpoint | Whether or not to enable the Data API for a serverless Aurora database engine | `bool` | `false` | no |
| enabled\_cloudwatch\_logs\_exports | List of log types to export to cloudwatch - `audit`, `error`, `general`, `slowquery`, `postgresql` | `list(string)` | `[]` | no |
| engine | Aurora database engine type, currently aurora, aurora-mysql or aurora-postgresql | `string` | `"aurora"` | no |
| engine\_mode | The database engine mode. Valid values: global, parallelquery, provisioned, serverless, multimaster | `string` | `"provisioned"` | no |
| engine\_version | Aurora database engine version | `string` | `"5.6.10a"` | no |
| final\_snapshot\_identifier\_prefix | The prefix name to use when creating a final snapshot on cluster destroy, appends a random 8 digits to name to ensure it's unique too. | `string` | `"final"` | no |
| global\_cluster\_identifier | The global cluster identifier specified on aws\_rds\_global\_cluster | `string` | `""` | no |
| iam\_database\_authentication\_enabled | Specifies whether IAM Database authentication should be enabled or not. Not all versions and instances are supported. Refer to the AWS documentation to see which versions are supported | `bool` | `false` | no |
| iam\_role\_description | Description of the role | `string` | `null` | no |
| iam\_role\_force\_detach\_policies | Whether to force detaching any policies the role has before destroying it | `bool` | `null` | no |
| iam\_role\_managed\_policy\_arns | Set of exclusive IAM managed policy ARNs to attach to the IAM role | `list(string)` | `null` | no |
| iam\_role\_max\_session\_duration | Maximum session duration (in seconds) that you want to set for the role | `number` | `null` | no |
| iam\_role\_name | Friendly name of the role | `string` | `null` | no |
| iam\_role\_path | Path to the role | `string` | `null` | no |
| iam\_role\_permissions\_boundary | The ARN of the policy that is used to set the permissions boundary for the role | `string` | `null` | no |
| iam\_role\_use\_name\_prefix | Whether to use `iam_role_name` as is or create a unique name beginning with the `iam_role_name` as the prefix | `bool` | `false` | no |
| iam\_roles | A List of ARNs for the IAM roles to associate to the RDS Cluster | `list(string)` | `[]` | no |
| instance\_type | Instance type to use at master instance. If instance\_type\_replica is not set it will use the same type for replica instances | `string` | `""` | no |
| instance\_type\_replica | Instance type to use at replica instance | `string` | `null` | no |
| instances\_parameters | Customized instance settings. Supported keys: `instance_name`, `instance_type`, `instance_promotion_tier`, `publicly_accessible` | `list(map(string))` | `[]` | no |
| is\_primary\_cluster | Whether to create a primary cluster (set to false to be a part of a Global database) | `bool` | `true` | no |
| kms\_key\_id | The ARN for the KMS encryption key if one is set to the cluster | `string` | `""` | no |
| monitoring\_interval | The interval (seconds) between points when Enhanced Monitoring metrics are collected | `number` | `0` | no |
| monitoring\_role\_arn | IAM role used by RDS to send enhanced monitoring metrics to CloudWatch | `string` | `""` | no |
| name | Name used across resources created | `string` | `""` | no |
| password | Master DB password. Note - when specifying a value here, 'create\_random\_password' should be set to `false` | `string` | `""` | no |
| performance\_insights\_enabled | Specifies whether Performance Insights is enabled or not | `bool` | `false` | no |
| performance\_insights\_kms\_key\_id | The ARN for the KMS key to encrypt Performance Insights data | `string` | `""` | no |
| port | The port on which to accept connections | `string` | `""` | no |
| predefined\_metric\_type | The metric type to scale on. Valid values are RDSReaderAverageCPUUtilization and RDSReaderAverageDatabaseConnections | `string` | `"RDSReaderAverageCPUUtilization"` | no |
| preferred\_backup\_window | When to perform DB backups | `string` | `"02:00-03:00"` | no |
| preferred\_maintenance\_window | When to perform DB maintenance | `string` | `"sun:05:00-sun:06:00"` | no |
| publicly\_accessible | Whether the DB should have a public IP address | `bool` | `false` | no |
| replica\_count | Number of reader nodes to create.  If `replica_scale_enable` is `true`, the value of `replica_scale_min` is used instead. | `number` | `1` | no |
| replica\_scale\_connections | Average number of connections threshold which will initiate autoscaling. Default value is 70% of db.r4.large's default max\_connections | `number` | `700` | no |
| replica\_scale\_cpu | CPU threshold which will initiate autoscaling | `number` | `70` | no |
| replica\_scale\_enabled | Whether to enable autoscaling for RDS Aurora (MySQL) read replicas | `bool` | `false` | no |
| replica\_scale\_in\_cooldown | Cooldown in seconds before allowing further scaling operations after a scale in | `number` | `300` | no |
| replica\_scale\_max | Maximum number of read replicas permitted when autoscaling is enabled | `number` | `0` | no |
| replica\_scale\_min | Minimum number of read replicas permitted when autoscaling is enabled | `number` | `2` | no |
| replica\_scale\_out\_cooldown | Cooldown in seconds before allowing further scaling operations after a scale out | `number` | `300` | no |
| replication\_source\_identifier | ARN of a source DB cluster or DB instance if this DB cluster is to be created as a Read Replica | `string` | `""` | no |
| s3\_import | Configuration map used to restore from a Percona Xtrabackup in S3 (only MySQL is supported) | `map(string)` | `null` | no |
| scaling\_configuration | Map of nested attributes with scaling properties. Only valid when engine\_mode is set to `serverless` | `map(string)` | `{}` | no |
| security\_group\_description | The description of the security group. If value is set to empty string it will contain cluster name in the description | `string` | `"Managed by Terraform"` | no |
| security\_group\_tags | Additional tags for the security group | `map(string)` | `{}` | no |
| skip\_final\_snapshot | Should a final snapshot be created on cluster destroy | `bool` | `false` | no |
| snapshot\_identifier | DB snapshot to create this database from | `string` | `null` | no |
| source\_region | The source region for an encrypted replica DB cluster | `string` | `""` | no |
| storage\_encrypted | Specifies whether the underlying storage layer should be encrypted | `bool` | `true` | no |
| subnets | List of subnet IDs used by database subnet group created | `list(string)` | `[]` | no |
| tags | A map of tags to add to all resources. | `map(string)` | `{}` | no |
| username | Master DB username | `string` | `"root"` | no |
| vpc\_id | VPC ID | `string` | `""` | no |
| vpc\_security\_group\_ids | List of VPC security groups to associate to the cluster in addition to the SG we create in this module | `list(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| this\_enhanced\_monitoring\_iam\_role\_arn | The Amazon Resource Name (ARN) specifying the enhanced monitoring role |
| this\_enhanced\_monitoring\_iam\_role\_name | The name of the enhanced monitoring role |
| this\_enhanced\_monitoring\_iam\_role\_unique\_id | Stable and unique string identifying the enhanced monitoring role |
| this\_rds\_cluster\_arn | The ID of the cluster |
| this\_rds\_cluster\_database\_name | Name for an automatically created database on cluster creation |
| this\_rds\_cluster\_endpoint | The cluster endpoint |
| this\_rds\_cluster\_engine\_version | The cluster engine version |
| this\_rds\_cluster\_hosted\_zone\_id | Route53 hosted zone id of the created cluster |
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

## Authors

Currently maintained by [Anton Babenko](https://github.com/antonbabenko) and [these awesome contributors](https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/graphs/contributors).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/tree/master/LICENSE) for full details.
