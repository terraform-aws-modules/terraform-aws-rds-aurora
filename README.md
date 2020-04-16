# AWS RDS Aurora Terraform module

Terraform module which creates RDS Aurora resources on AWS.

These types of resources are supported:

* [RDS Cluster](https://www.terraform.io/docs/providers/aws/r/rds_cluster.html)
* [RDS Cluster Instance](https://www.terraform.io/docs/providers/aws/r/rds_cluster_instance.html)
* [DB Subnet Group](https://www.terraform.io/docs/providers/aws/r/db_subnet_group.html)
* [Application AutoScaling Policy](https://www.terraform.io/docs/providers/aws/r/appautoscaling_policy.html)
* [Application AutoScaling Target](https://www.terraform.io/docs/providers/aws/r/appautoscaling_target.html)

## Terraform versions

Terraform 0.12. Pin module version to `~> v2.0`. Submit pull-requests to `master` branch.

Terraform 0.11. Pin module version to `~> v1.0`. Submit pull-requests to `terraform011` branch.

## Available features

- Autoscaling of read-replicas (based on CPU utilization)
- Enhanced Monitoring

## Usage

```hcl
module "db" {
  source  = "terraform-aws-modules/rds-aurora/aws"
  version = "~> 2.0"

  name                            = "test-aurora-db-postgres96"

  engine                          = "aurora-postgresql"
  engine_version                  = "9.6.9"

  vpc_id                          = "vpc-12345678"
  subnets                         = ["subnet-12345678", "subnet-87654321"]

  replica_count                   = 1
  allowed_security_groups         = ["sg-12345678"]
  allowed_cidr_blocks             = ["10.20.0.0/20"]
  instance_type                   = "db.r4.large"
  storage_encrypted               = true
  apply_immediately               = true
  monitoring_interval             = 10

  db_parameter_group_name         = "default"
  db_cluster_parameter_group_name = "default"

  enabled_cloudwatch_logs_exports = ["audit", "error", "general", "slowquery"]

  tags                            = {
    Environment = "dev"
    Terraform   = "true"
  }
}
```

## Examples

- [PostgreSQL](examples/postgresql): A simple example with VPC and PostgreSQL cluster.
- [MySQL](examples/mysql): A simple example with VPC and MySQL cluster.
- [Serverless](examples/serverless): Serverless PostgreSQL cluster.
- [Advanced](examples/advanced): A PostgreSQL cluster with enhanced monitoring and autoscaling enabled.

## Documentation

Terraform documentation is generated automatically using [pre-commit hooks](http://www.pre-commit.com/). Follow installation instructions [here](https://pre-commit.com/#install).

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Providers

| Name | Version |
|------|---------|
| aws | ~> 2.0 |
| random | ~> 2.2 |

## Inputs

| Name | Description | Type | Default | Required |
<<<<<<< HEAD
|------|-------------|:----:|:-----:|:-----:|
| allowed\_security\_groups | A list of Security Group ID's to allow access to. | list | `[]` | no |
| allowed\_security\_groups\_count | The number of Security Groups being added, terraform doesn't let us use length() in a count field | string | `"0"` | no |
| apply\_immediately | Determines whether or not any DB modifications are applied immediately, or during the maintenance window | string | `"false"` | no |
| auto\_minor\_version\_upgrade | Determines whether minor engine upgrades will be performed automatically in the maintenance window | string | `"true"` | no |
| backup\_retention\_period | How long to keep backups for (in days) | string | `"7"` | no |
| ca\_cert\_identifier | Which RDS cert to use | string | `"rds-ca-2019"` | no |
| database\_name | Name for an automatically created database on cluster creation | string | `""` | no |
| db\_cluster\_parameter\_group\_name | The name of a DB Cluster parameter group to use | string | `"default.aurora5.6"` | no |
| db\_parameter\_group\_name | The name of a DB parameter group to use | string | `"default.aurora5.6"` | no |
| deletion\_protection | If the DB instance should have deletion protection enabled | string | `"false"` | no |
| enabled\_cloudwatch\_logs\_exports | List of log types to export to cloudwatch | list | `[]` | no |
| engine | Aurora database engine type, currently aurora, aurora-mysql or aurora-postgresql | string | `"aurora"` | no |
| engine\_mode | The database engine mode. Valid values: global, parallelquery, provisioned, serverless. | string | `"provisioned"` | no |
| engine\_version | Aurora database engine version. | string | `"5.6.10a"` | no |
| final\_snapshot\_identifier\_prefix | The prefix name to use when creating a final snapshot on cluster destroy, appends a random 8 digits to name to ensure it's unique too. | string | `"final"` | no |
| global\_cluster\_identifier | The global cluster identifier specified on aws_rds_global_cluster | string | `""` | no |
| iam\_database\_authentication\_enabled | Specifies whether IAM Database authentication should be enabled or not. Not all versions and instances are supported. Refer to the AWS documentation to see which versions are supported. | string | `"false"` | no |
| instance\_type | Instance type to use | string | n/a | yes |
| kms\_key\_id | The ARN for the KMS encryption key if one is set to the cluster. | string | `""` | no |
| monitoring\_interval | The interval (seconds) between points when Enhanced Monitoring metrics are collected | string | `"0"` | no |
| name | Name given resources | string | n/a | yes |
| password | Master DB password | string | `""` | no |
| performance\_insights\_enabled | Specifies whether Performance Insights is enabled or not. | string | `"false"` | no |
| performance\_insights\_kms\_key\_id | The ARN for the KMS key to encrypt Performance Insights data. | string | `""` | no |
| port | The port on which to accept connections | string | `""` | no |
| preferred\_backup\_window | When to perform DB backups | string | `"02:00-03:00"` | no |
| preferred\_maintenance\_window | When to perform DB maintenance | string | `"sun:05:00-sun:06:00"` | no |
| publicly\_accessible | Whether the DB should have a public IP address | string | `"false"` | no |
| replica\_count | Number of reader nodes to create.  If `replica_scale_enable` is `true`, the value of `replica_scale_min` is used instead. | string | `"1"` | no |
| replica\_scale\_cpu | CPU usage to trigger autoscaling at | string | `"70"` | no |
| replica\_scale\_enabled | Whether to enable autoscaling for RDS Aurora (MySQL) read replicas | string | `"false"` | no |
| replica\_scale\_in\_cooldown | Cooldown in seconds before allowing further scaling operations after a scale in | string | `"300"` | no |
| replica\_scale\_max | Maximum number of replicas to allow scaling for | string | `"0"` | no |
| replica\_scale\_min | Minimum number of replicas to allow scaling for | string | `"2"` | no |
| replica\_scale\_out\_cooldown | Cooldown in seconds before allowing further scaling operations after a scale out | string | `"300"` | no |
| skip\_final\_snapshot | Should a final snapshot be created on cluster destroy | string | `"false"` | no |
| snapshot\_identifier | DB snapshot to create this database from | string | `""` | no |
| storage\_encrypted | Specifies whether the underlying storage layer should be encrypted | string | `"true"` | no |
| subnets | List of subnet IDs to use | list | n/a | yes |
| tags | A map of tags to add to all resources. | map | `{}` | no |
| timeouts | Set how many minutes to wait for DB resources to be created/updated/deleted. | string | `"120m"` | no |
| username | Master DB username | string | `"root"` | no |
| vpc\_id | VPC ID | string | n/a | yes |
=======
|------|-------------|------|---------|:-----:|
| allowed\_cidr\_blocks | A list of CIDR blocks which are allowed to access the database | `list(string)` | `[]` | no |
| allowed\_security\_groups | A list of Security Group ID's to allow access to. | `list(string)` | `[]` | no |
| apply\_immediately | Determines whether or not any DB modifications are applied immediately, or during the maintenance window | `bool` | `false` | no |
| auto\_minor\_version\_upgrade | Determines whether minor engine upgrades will be performed automatically in the maintenance window | `bool` | `true` | no |
| backtrack\_window | The target backtrack window, in seconds. Only available for aurora engine currently. To disable backtracking, set this value to 0. Defaults to 0. Must be between 0 and 259200 (72 hours) | `number` | `0` | no |
| backup\_retention\_period | How long to keep backups for (in days) | `number` | `7` | no |
| ca\_cert\_identifier | The identifier of the CA certificate for the DB instance | `string` | `"rds-ca-2019"` | no |
| copy\_tags\_to\_snapshot | Copy all Cluster tags to snapshots. | `bool` | `false` | no |
| create\_security\_group | Whether to create security group for RDS cluster | `bool` | `true` | no |
| database\_name | Name for an automatically created database on cluster creation | `string` | `""` | no |
| db\_cluster\_parameter\_group\_name | The name of a DB Cluster parameter group to use | `string` | n/a | yes |
| db\_parameter\_group\_name | The name of a DB parameter group to use | `string` | n/a | yes |
| db\_subnet\_group\_name | The existing subnet group name to use | `string` | `""` | no |
| deletion\_protection | If the DB instance should have deletion protection enabled | `bool` | `false` | no |
| enabled\_cloudwatch\_logs\_exports | List of log types to export to cloudwatch | `list(string)` | `[]` | no |
| engine | Aurora database engine type, currently aurora, aurora-mysql or aurora-postgresql | `string` | `"aurora"` | no |
| engine\_mode | The database engine mode. Valid values: global, parallelquery, provisioned, serverless. | `string` | `"provisioned"` | no |
| engine\_version | Aurora database engine version. | `string` | `"5.6.10a"` | no |
| final\_snapshot\_identifier\_prefix | The prefix name to use when creating a final snapshot on cluster destroy, appends a random 8 digits to name to ensure it's unique too. | `string` | `"final"` | no |
| global\_cluster\_identifier | The global cluster identifier specified on aws\_rds\_global\_cluster | `string` | `""` | no |
| iam\_database\_authentication\_enabled | Specifies whether IAM Database authentication should be enabled or not. Not all versions and instances are supported. Refer to the AWS documentation to see which versions are supported. | `bool` | `false` | no |
| iam\_roles | A List of ARNs for the IAM roles to associate to the RDS Cluster. | `list(string)` | `[]` | no |
| instance\_type | Instance type to use | `string` | n/a | yes |
| kms\_key\_id | The ARN for the KMS encryption key if one is set to the cluster. | `string` | `""` | no |
| monitoring\_interval | The interval (seconds) between points when Enhanced Monitoring metrics are collected | `number` | `0` | no |
| name | Name given resources | `string` | n/a | yes |
| password | Master DB password | `string` | `""` | no |
| performance\_insights\_enabled | Specifies whether Performance Insights is enabled or not. | `bool` | `false` | no |
| performance\_insights\_kms\_key\_id | The ARN for the KMS key to encrypt Performance Insights data. | `string` | `""` | no |
| port | The port on which to accept connections | `string` | `""` | no |
| predefined\_metric\_type | The metric type to scale on. Valid values are RDSReaderAverageCPUUtilization and RDSReaderAverageDatabaseConnections. | `string` | `"RDSReaderAverageCPUUtilization"` | no |
| preferred\_backup\_window | When to perform DB backups | `string` | `"02:00-03:00"` | no |
| preferred\_maintenance\_window | When to perform DB maintenance | `string` | `"sun:05:00-sun:06:00"` | no |
| publicly\_accessible | Whether the DB should have a public IP address | `bool` | `false` | no |
| replica\_count | Number of reader nodes to create.  If `replica_scale_enable` is `true`, the value of `replica_scale_min` is used instead. | `number` | `1` | no |
| replica\_scale\_connections | Average number of connections to trigger autoscaling at. Default value is 70% of db.r4.large's default max\_connections | `number` | `700` | no |
| replica\_scale\_cpu | CPU usage to trigger autoscaling at | `number` | `70` | no |
| replica\_scale\_enabled | Whether to enable autoscaling for RDS Aurora (MySQL) read replicas | `bool` | `false` | no |
| replica\_scale\_in\_cooldown | Cooldown in seconds before allowing further scaling operations after a scale in | `number` | `300` | no |
| replica\_scale\_max | Maximum number of replicas to allow scaling for | `number` | `0` | no |
| replica\_scale\_min | Minimum number of replicas to allow scaling for | `number` | `2` | no |
| replica\_scale\_out\_cooldown | Cooldown in seconds before allowing further scaling operations after a scale out | `number` | `300` | no |
| replication\_source\_identifier | ARN of a source DB cluster or DB instance if this DB cluster is to be created as a Read Replica. | `string` | `""` | no |
| scaling\_configuration | Map of nested attributes with scaling properties. Only valid when engine\_mode is set to `serverless` | `map(string)` | `{}` | no |
| security\_group\_description | The description of the security group. If value is set to empty string it will contain cluster name in the description. | `string` | `"Managed by Terraform"` | no |
| skip\_final\_snapshot | Should a final snapshot be created on cluster destroy | `bool` | `false` | no |
| snapshot\_identifier | DB snapshot to create this database from | `string` | `""` | no |
| source\_region | The source region for an encrypted replica DB cluster. | `string` | `""` | no |
| storage\_encrypted | Specifies whether the underlying storage layer should be encrypted | `bool` | `true` | no |
| subnets | List of subnet IDs to use | `list(string)` | `[]` | no |
| tags | A map of tags to add to all resources. | `map(string)` | `{}` | no |
| username | Master DB username | `string` | `"root"` | no |
| vpc\_id | VPC ID | `string` | n/a | yes |
| vpc\_security\_group\_ids | List of VPC security groups to associate to the cluster in addition to the SG we create in this module | `list(string)` | `[]` | no |
>>>>>>> 9645f7bd1db6c468e3cea651b9b8ae56e78ade36

## Outputs

| Name | Description |
|------|-------------|
| this\_rds\_cluster\_arn | The ID of the cluster |
| this\_rds\_cluster\_database\_name | Name for an automatically created database on cluster creation |
| this\_rds\_cluster\_endpoint | The cluster endpoint |
| this\_rds\_cluster\_id | The ID of the cluster |
| this\_rds\_cluster\_instance\_endpoints | A list of all cluster instance endpoints |
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

MIT Licensed. See [LICENSE](https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/tree/master/LICENSE) for full details.
