# terraform-aws-rds-aurora

Creates a AWS Aurora DB cluster & instances, including:

 - A DB subnet group
 - An Aurora DB cluster
 - An Aurora DB instance or instances

 And optionally:

 - RDS Enhanced Monitoring and associated required IAM role/policy
 - Sensible cloudwatch alarms and SNS topic
 - Autoscaling for read replicas (MySQL clusters only)

## Usage examples

*It is recommended you always create a parameter group, even if it exactly matches the defaults.*

Changing the parameter group in use requires a restart of the DB cluster, modifying parameters within a group
may not (depending on the parameter being altered)

## Known issues

AWS doesn't automatically remove RDS instances created from autoscaling when you remove the autoscaling rules and this can cause issues when using Terraform to destroy the cluster.  To work around this, you should make sure there are no automatically created RDS instances running before attempting to destroy a cluster.

### Aurora 1.x (MySQL 5.6)

```hcl
resource "aws_sns_topic" "db_alarms_56" {
  name = "aurora-db-alarms-56"
}

module "aurora_db_56" {
  source                          = "claranet/aurora/aws"
  name                            = "test-aurora-db-56"
  envname                         = "test56"
  envtype                         = "test"
  subnets                         = ["${module.vpc.private_subnets}"]
  azs                             = ["${module.vpc.availability_zones}"]
  replica_count                   = "1"
  security_groups                 = ["${aws_security_group.allow_all.id}"]
  instance_type                   = "db.t2.medium"
  username                        = "root"
  password                        = "changeme"
  backup_retention_period         = "5"
  final_snapshot_identifier       = "final-db-snapshot-prod"
  storage_encrypted               = "true"
  apply_immediately               = "true"
  monitoring_interval             = "10"
  cw_alarms                       = true
  cw_sns_topic                    = "${aws_sns_topic.db_alarms_56.id}"
  db_parameter_group_name         = "${aws_db_parameter_group.aurora_db_56_parameter_group.id}"
  db_cluster_parameter_group_name = "${aws_rds_cluster_parameter_group.aurora_cluster_56_parameter_group.id}"
}

resource "aws_db_parameter_group" "aurora_db_56_parameter_group" {
  name        = "test-aurora-db-56-parameter-group"
  family      = "aurora5.6"
  description = "test-aurora-db-56-parameter-group"
}

resource "aws_rds_cluster_parameter_group" "aurora_cluster_56_parameter_group" {
  name        = "test-aurora-56-cluster-parameter-group"
  family      = "aurora5.6"
  description = "test-aurora-56-cluster-parameter-group"
}
```

### Aurora 2.x (MySQL 5.7)

```hcl
resource "aws_sns_topic" "db_alarms" {
  name = "aurora-db-alarms"
}

module "aurora_db_57" {
  source                          = "claranet/aurora/aws"
  engine                          = "aurora-mysql"
  engine-version                  = "5.7.12"
  name                            = "test-aurora-db-57"
  envname                         = "test-57"
  envtype                         = "test"
  subnets                         = ["${module.vpc.private_subnets}"]
  azs                             = ["${module.vpc.availability_zones}"]
  replica_count                   = "1"
  security_groups                 = ["${aws_security_group.allow_all.id}"]
  instance_type                   = "db.t2.medium"
  username                        = "root"
  password                        = "changeme"
  backup_retention_period         = "5"
  final_snapshot_identifier       = "final-db-snapshot-prod"
  storage_encrypted               = "true"
  apply_immediately               = "true"
  monitoring_interval             = "10"
  cw_alarms                       = true
  cw_sns_topic                    = "${aws_sns_topic.db_alarms.id}"
  db_parameter_group_name         = "${aws_db_parameter_group.aurora_db_57_parameter_group.id}"
  db_cluster_parameter_group_name = "${aws_rds_cluster_parameter_group.aurora_57_cluster_parameter_group.id}"
}

resource "aws_db_parameter_group" "aurora_db_57_parameter_group" {
  name        = "test-aurora-db-57-parameter-group"
  family      = "aurora-mysql5.7"
  description = "test-aurora-db-57-parameter-group"
}

resource "aws_rds_cluster_parameter_group" "aurora_57_cluster_parameter_group" {
  name        = "test-aurora-57-cluster-parameter-group"
  family      = "aurora-mysql5.7"
  description = "test-aurora-57-cluster-parameter-group"
}
```
### Aurora PostgreSQL

```hcl
resource "aws_sns_topic" "db_alarms_postgres96" {
  name = "aurora-db-alarms-postgres96"
}

module "aurora_db_postgres96" {
  source                          = "claranet/aurora/aws"
  engine                          = "aurora-postgresql"
  engine-version                  = "9.6.3"
  name                            = "test-aurora-db-postgres96"
  envname                         = "test-pg96"
  envtype                         = "test"
  subnets                         = ["${module.vpc.private_subnets}"]
  azs                             = ["${module.vpc.availability_zones}"]
  replica_count                   = "1"
  security_groups                 = ["${aws_security_group.allow_all.id}"]
  instance_type                   = "db.r4.large"
  username                        = "root"
  password                        = "changeme"
  backup_retention_period         = "5"
  final_snapshot_identifier       = "final-db-snapshot-prod"
  storage_encrypted               = "true"
  apply_immediately               = "true"
  monitoring_interval             = "10"
  cw_alarms                       = true
  cw_sns_topic                    = "${aws_sns_topic.db_alarms_postgres96.id}"
  db_parameter_group_name         = "${aws_db_parameter_group.aurora_db_postgres96_parameter_group.id}"
  db_cluster_parameter_group_name = "${aws_rds_cluster_parameter_group.aurora_cluster_postgres96_parameter_group.id}"
}

resource "aws_db_parameter_group" "aurora_db_postgres96_parameter_group" {
  name        = "test-aurora-db-postgres96-parameter-group"
  family      = "aurora-postgresql9.6"
  description = "test-aurora-db-postgres96-parameter-group"
}

resource "aws_rds_cluster_parameter_group" "aurora_cluster_postgres96_parameter_group" {
  name        = "test-aurora-postgres96-cluster-parameter-group"
  family      = "aurora-postgresql9.6"
  description = "test-aurora-postgres96-cluster-parameter-group"
}
```


## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| apply_immediately | Determines whether or not any DB modifications are applied immediately, or during the maintenance window | string | `false` | no |
| auto_minor_version_upgrade | Determines whether minor engine upgrades will be performed automatically in the maintenance window | string | `true` | no |
| azs | List of AZs to use | list | - | yes |
| backup_retention_period | How long to keep backups for (in days) | string | `7` | no |
| cw_alarms | Whether to enable CloudWatch alarms - requires `cw_sns_topic` is specified | string | `false` | no |
| cw_max_conns | Connection count beyond which to trigger a CloudWatch alarm | string | `500` | no |
| cw_max_cpu | CPU threshold above which to alarm | string | `85` | no |
| cw_max_replica_lag | Maximum Aurora replica lag in milliseconds above which to alarm | string | `2000` | no |
| cw_sns_topic | An SNS topic to publish CloudWatch alarms to | string | `false` | no |
| db_cluster_parameter_group_name | The name of a DB Cluster parameter group to use | string | `default.aurora5.6` | no |
| db_parameter_group_name | The name of a DB parameter group to use | string | `default.aurora5.6` | no |
| engine | Aurora database engine type, currently aurora, aurora-mysql or aurora-postgresql | string | `aurora` | no |
| engine-version | Aurora database engine version. | string | `5.6.10a` | no |
| envname | Environment name (eg,test, stage or prod) | string | - | yes |
| envtype | Environment type (eg,prod or nonprod) | string | - | yes |
| final_snapshot_identifier | The name to use when creating a final snapshot on cluster destroy, appends a random 8 digits to name to ensure it's unique too. | string | `final` | no |
| identifier_prefix | Prefix for cluster and instance identifier | string | `` | no |
| instance_type | Instance type to use | string | `db.t2.small` | no |
| monitoring_interval | The interval (seconds) between points when Enhanced Monitoring metrics are collected | string | `0` | no |
| name | Name given to DB subnet group | string | - | yes |
| password | Master DB password | string | - | yes |
| port | The port on which to accept connections | string | `3306` | no |
| preferred_backup_window | When to perform DB backups | string | `02:00-03:00` | no |
| preferred_maintenance_window | When to perform DB maintenance | string | `sun:05:00-sun:06:00` | no |
| publicly_accessible | Whether the DB should have a public IP address | string | `false` | no |
| replica_count | Number of reader nodes to create.  If `replica_scale_enable` is `true`, the value of `replica_scale_min` is used instead. | string | `0` | no |
| replica_scale_cpu | CPU usage to trigger autoscaling at | string | `70` | no |
| replica_scale_enabled | Whether to enable autoscaling for RDS Aurora (MySQL) read replicas | string | `false` | no |
| replica_scale_in_cooldown | Cooldown in seconds before allowing further scaling operations after a scale in | string | `300` | no |
| replica_scale_max | Maximum number of replicas to allow scaling for | string | `0` | no |
| replica_scale_min | Maximum number of replicas to allow scaling for | string | `2` | no |
| replica_scale_out_cooldown | Cooldown in seconds before allowing further scaling operations after a scale out | string | `300` | no |
| security_groups | VPC Security Group IDs | list | - | yes |
| skip_final_snapshot | Should a final snapshot be created on cluster destroy | string | `false` | no |
| snapshot_identifier | DB snapshot to create this database from | string | `` | no |
| storage_encrypted | Specifies whether the underlying storage layer should be encrypted | string | `true` | no |
| subnets | List of subnet IDs to use | list | - | yes |
| username | Master DB username | string | `root` | no |

## Outputs

| Name | Description |
|------|-------------|
| all_instance_endpoints_list | Comma separated list of all DB instance endpoints running in cluster |
| cluster_endpoint | The 'writer' endpoint for the cluster |
| reader_endpoint | A read-only endpoint for the Aurora cluster, automatically load-balanced across replicas |
