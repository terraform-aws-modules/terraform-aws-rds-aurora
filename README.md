# AWS RDS Aurora Terraform module

Terraform module which creates RDS Aurora resources on AWS.

These types of resources are supported:

* [RDS Cluster](https://www.terraform.io/docs/providers/aws/r/rds_cluster.html)
* [RDS Cluster Instance](https://www.terraform.io/docs/providers/aws/r/rds_cluster_instance.html)
* [DB Subnet Group](https://www.terraform.io/docs/providers/aws/r/db_subnet_group.html)
* [Application AutoScaling Policy](https://www.terraform.io/docs/providers/aws/r/appautoscaling_policy.html)
* [Application AutoScaling Target](https://www.terraform.io/docs/providers/aws/r/appautoscaling_target.html)

## Available features

- Autoscaling of read-replicas (based on CPU utilization)
- Enhanced Monitoring

## Usage

```hcl
module "db" {
  source                          = "terraform-aws-modules/rds-aurora/aws"

  name                            = "test-aurora-db-postgres96"

  engine                          = "aurora-postgresql"
  engine_version                  = "9.6.3"

  vpc_id                          = "vpc-12345678"
  subnets                         = ["subnet-12345678", "subnet-87654321"]

  replica_count                   = 1
  allowed_security_groups         = ["sg-12345678"]
  allowed_security_groups_count   = 1
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

- [PostgreSQL](examples/postgres): A simple example with VPC and PostgreSQL cluster.
- [MySQL](examples/mysql): A simple example with VPC and MySQL cluster.
- [Advanced](examples/advanced): A PostgreSQL cluster with enhanced monitoring and autoscaling enabled.

## Documentation

Terraform documentation is generated automatically using [pre-commit hooks](http://www.pre-commit.com/). Follow installation instructions [here](https://pre-commit.com/#install).

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| allowed\_security\_groups | A list of Security Group ID's to allow access to. | list | `[]` | no |
| allowed\_security\_groups\_count | The number of Security Groups being added, terraform doesn't let us use length() in a count field | string | `"0"` | no |
| apply\_immediately | Determines whether or not any DB modifications are applied immediately, or during the maintenance window | string | `"false"` | no |
| auto\_minor\_version\_upgrade | Determines whether minor engine upgrades will be performed automatically in the maintenance window | string | `"true"` | no |
| backup\_retention\_period | How long to keep backups for (in days) | string | `"7"` | no |
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
| identifier\_prefix | Prefix for cluster and instance identifier | string | `""` | no |
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
| replica\_scale\_min | Maximum number of replicas to allow scaling for | string | `"2"` | no |
| replica\_scale\_out\_cooldown | Cooldown in seconds before allowing further scaling operations after a scale out | string | `"300"` | no |
| skip\_final\_snapshot | Should a final snapshot be created on cluster destroy | string | `"false"` | no |
| snapshot\_identifier | DB snapshot to create this database from | string | `""` | no |
| storage\_encrypted | Specifies whether the underlying storage layer should be encrypted | string | `"true"` | no |
| subnets | List of subnet IDs to use | list | n/a | yes |
| tags | A map of tags to add to all resources. | map | `{}` | no |
| username | Master DB username | string | `"root"` | no |
| vpc\_id | VPC ID | string | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
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
