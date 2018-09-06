# terraform-aws-rds-aurora

Creates a AWS Aurora RDS cluster, cluster instances and DB subnet group.

Optional Aurora features can also be enabled:

- Autoscaling of replicas
- Enhanced Monitoring

### Usage

```hcl
module "aurora_db_postgres96" {
  source                          = "path/to/module"
  name                            = "test-aurora-db-postgres96"
  engine                          = "aurora-postgresql"
  engine-version                  = "9.6.3"
  subnets                         = ["${module.vpc.database_subnets}"]
  azs                             = ["${module.vpc.availability_zones}"]
  vpc_id                          = "${module.vpc.vpc_id}"
  replica_count                   = "1"
  allowed_security_groups         = ["${aws_security_group.my_application.id}"]
  instance_type                   = "db.r4.large"
  storage_encrypted               = "true"
  apply_immediately               = "true"
  monitoring_interval             = "10"
  db_parameter_group_name         = "${aws_db_parameter_group.aurora_db_postgres96_parameter_group.id}"
  db_cluster_parameter_group_name = "${aws_rds_cluster_parameter_group.aurora_cluster_postgres96_parameter_group.id}"
  tags                            = {
    "environment" = "dev"
    "terraform"   = "true"
  }
}
```

### Full examples

- [PostgreSQL](examples/postgres): A simple example with VPC and PostgreSQL cluster.
- [MySQL](examples/mysql): A simple example with VPC and MySQL cluster.
- [Advanced](examples/advanced): A PostgreSQL cluster with enhanced monitoring and autoscaling enabled.

## Documentation generation

Documentation should be modified within `main.tf` and generated using [terraform-docs](https://github.com/segmentio/terraform-docs):

```bash
terraform-docs md ./ | cat -s | tail -r | tail -n +2 | tail -r > README.md
```

## License

MIT Licensed. See [LICENSE](https://github.com/deliveryhero/tf-ssh-bastion/tree/master/LICENSE) for full details.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| allowed_security_groups | A list of Security Group ID's to allow access to. | list | `<list>` | no |
| apply_immediately | Determines whether or not any DB modifications are applied immediately, or during the maintenance window | string | `false` | no |
| auto_minor_version_upgrade | Determines whether minor engine upgrades will be performed automatically in the maintenance window | string | `true` | no |
| availability_zones | Availability zones for the cluster. Must 3 or less | list | `<list>` | no |
| backup_retention_period | How long to keep backups for (in days) | string | `7` | no |
| db_cluster_parameter_group_name | The name of a DB Cluster parameter group to use | string | `default.aurora5.6` | no |
| db_parameter_group_name | The name of a DB parameter group to use | string | `default.aurora5.6` | no |
| engine | Aurora database engine type, currently aurora, aurora-mysql or aurora-postgresql | string | `aurora` | no |
| engine-version | Aurora database engine version. | string | `5.6.10a` | no |
| final_snapshot_identifier_prefix | The prefix name to use when creating a final snapshot on cluster destroy, appends a random 8 digits to name to ensure it's unique too. | string | `final` | no |
| identifier_prefix | Prefix for cluster and instance identifier | string | `` | no |
| instance_type | Instance type to use | string | `db.r4.large` | no |
| kms_key_id | The ARN for the KMS encryption key if one is set to the cluster. | string | `` | no |
| monitoring_interval | The interval (seconds) between points when Enhanced Monitoring metrics are collected | string | `0` | no |
| name | Name given resources | string | - | yes |
| password | Master DB password | string | `` | no |
| performance_insights_enabled | Specifies whether Performance Insights is enabled or not. | string | `false` | no |
| performance_insights_kms_key_id | The ARN for the KMS key to encrypt Performance Insights data. | string | `` | no |
| port | The port on which to accept connections | string | `` | no |
| preferred_backup_window | When to perform DB backups | string | `02:00-03:00` | no |
| preferred_maintenance_window | When to perform DB maintenance | string | `sun:05:00-sun:06:00` | no |
| publicly_accessible | Whether the DB should have a public IP address | string | `false` | no |
| replica_count | Number of reader nodes to create.  If `replica_scale_enable` is `true`, the value of `replica_scale_min` is used instead. | string | `1` | no |
| replica_scale_cpu | CPU usage to trigger autoscaling at | string | `70` | no |
| replica_scale_enabled | Whether to enable autoscaling for RDS Aurora (MySQL) read replicas | string | `false` | no |
| replica_scale_in_cooldown | Cooldown in seconds before allowing further scaling operations after a scale in | string | `300` | no |
| replica_scale_max | Maximum number of replicas to allow scaling for | string | `0` | no |
| replica_scale_min | Maximum number of replicas to allow scaling for | string | `2` | no |
| replica_scale_out_cooldown | Cooldown in seconds before allowing further scaling operations after a scale out | string | `300` | no |
| skip_final_snapshot | Should a final snapshot be created on cluster destroy | string | `false` | no |
| snapshot_identifier | DB snapshot to create this database from | string | `` | no |
| storage_encrypted | Specifies whether the underlying storage layer should be encrypted | string | `true` | no |
| subnets | List of subnet IDs to use | list | - | yes |
| tags | A map of tags to add to all resources. | map | `<map>` | no |
| username | Master DB username | string | `root` | no |
| vpc_id | VPC ID | string | - | yes |

## Outputs

| Name | Description |
|------|-------------|
| endpoint | The cluster endpoint |
| instance_endpoints | A list of all cluster instance endpoints |
| master_password | The master password |
| master_username | The master username |
| port | The port |
| rds_cluster_id | The ID of the cluster |
| reader_endpoint | The cluster reader endpoint |
| security_group_id | The security group ID of the cluster |
