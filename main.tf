/**
  * # tf-aws-aurora
  *
  * AWS Aurora DB Cluster & Instance(s) Terraform Module.
  *
  * Gives you:
  *
  *  - A DB subnet group
  *  - An Aurora DB cluster
  *  - An Aurora DB instance + 'n' number of additional instances
  *  - Optionally RDS 'Enhanced Monitoring' + associated required IAM role/policy (by simply setting the `monitoring_interval` param to > `0`
  *  - Optionally sensible alarms to SNS (high CPU, high connections, slow replication)
  *  - Optionally configure autoscaling for read replicas (MySQL clusters only)
  *
  * ## Contributing
  *
  * Ensure any variables you add have a type and a description.
  * This README is generated with [terraform-docs](https://github.com/segmentio/terraform-docs):
  *
  * `terraform-docs md . > README.md`
  *
  * ## Usage examples
  *
  * *It is recommended you always create a parameter group, even if it exactly matches the defaults.*
  * Changing the parameter group in use requires a restart of the DB cluster, modifying parameters within a group
  * may not (depending on the parameter being altered)
  *
  * ## Known issues
  * AWS doesn't automatically remove RDS instances created from autoscaling when you remove the autoscaling rules and this can cause issues when using Terraform to destroy the cluster.  To work around this, you should make sure there are no automatically created RDS instances running before attempting to destroy a cluster.
  *
  * ### Aurora 1.x (MySQL 5.6)
  *
  *
  * resource "aws_sns_topic" "db_alarms_56" {
  *   name = "aurora-db-alarms-56"
  * }
  *
  * module "aurora_db_56" {
  *   source                          = "../.."
  *   name                            = "test-aurora-db-56"
  *   envname                         = "test56"
  *   envtype                         = "test"
  *   subnets                         = ["${module.vpc.private_subnets}"]
  *   azs                             = ["${module.vpc.availability_zones}"]
  *   replica_count                   = "1"
  *   security_groups                 = ["${aws_security_group.allow_all.id}"]
  *   instance_type                   = "db.t2.medium"
  *   username                        = "root"
  *   password                        = "changeme"
  *   backup_retention_period         = "5"
  *   final_snapshot_identifier       = "final-db-snapshot-prod"
  *   storage_encrypted               = "true"
  *   apply_immediately               = "true"
  *   monitoring_interval             = "10"
  *   cw_alarms                       = true
  *   cw_sns_topic                    = "${aws_sns_topic.db_alarms_56.id}"
  *   db_parameter_group_name         = "${aws_db_parameter_group.aurora_db_56_parameter_group.id}"
  *   db_cluster_parameter_group_name = "${aws_rds_cluster_parameter_group.aurora_cluster_56_parameter_group.id}"
  * }
  *
  * resource "aws_db_parameter_group" "aurora_db_56_parameter_group" {
  *   name        = "test-aurora-db-56-parameter-group"
  *   family      = "aurora5.6"
  *   description = "test-aurora-db-56-parameter-group"
  * }
  *
  * resource "aws_rds_cluster_parameter_group" "aurora_cluster_56_parameter_group" {
  *   name        = "test-aurora-56-cluster-parameter-group"
  *   family      = "aurora5.6"
  *   description = "test-aurora-56-cluster-parameter-group"
  * }
  *
  * ### Aurora 2.x (MySQL 5.7)
  *
  * ```hcl
  * resource "aws_sns_topic" "db_alarms" {
  *   name = "aurora-db-alarms"
  * }
  *
  * module "aurora_db_57" {
  *   source                          = "../.."
  *   engine                          = "aurora-mysql"
  *   engine-version                  = "5.7.12"
  *   name                            = "test-aurora-db-57"
  *   envname                         = "test-57"
  *   envtype                         = "test"
  *   subnets                         = ["${module.vpc.private_subnets}"]
  *   azs                             = ["${module.vpc.availability_zones}"]
  *   replica_count                   = "1"
  *   security_groups                 = ["${aws_security_group.allow_all.id}"]
  *   instance_type                   = "db.t2.medium"
  *   username                        = "root"
  *   password                        = "changeme"
  *   backup_retention_period         = "5"
  *   final_snapshot_identifier       = "final-db-snapshot-prod"
  *   storage_encrypted               = "true"
  *   apply_immediately               = "true"
  *   monitoring_interval             = "10"
  *   cw_alarms                       = true
  *   cw_sns_topic                    = "${aws_sns_topic.db_alarms.id}"
  *   db_parameter_group_name         = "${aws_db_parameter_group.aurora_db_57_parameter_group.id}"
  *   db_cluster_parameter_group_name = "${aws_rds_cluster_parameter_group.aurora_57_cluster_parameter_group.id}"
  * }
  *
  * resource "aws_db_parameter_group" "aurora_db_57_parameter_group" {
  *   name        = "test-aurora-db-57-parameter-group"
  *   family      = "aurora-mysql5.7"
  *   description = "test-aurora-db-57-parameter-group"
  * }
  *
  * resource "aws_rds_cluster_parameter_group" "aurora_57_cluster_parameter_group" {
  *   name        = "test-aurora-57-cluster-parameter-group"
  *   family      = "aurora-mysql5.7"
  *   description = "test-aurora-57-cluster-parameter-group"
  * }
  * ```
  ### Aurora PostgreSQL
  *
  * ```hcl
  * resource "aws_sns_topic" "db_alarms_postgres96" {
  *   name = "aurora-db-alarms-postgres96"
  * }
  *
  * module "aurora_db_postgres96" {
  *   source                          = "../.."
  *   engine                          = "aurora-postgresql"
  *   engine-version                  = "9.6.3"
  *   name                            = "test-aurora-db-postgres96"
  *   envname                         = "test-pg96"
  *   envtype                         = "test"
  *   subnets                         = ["${module.vpc.private_subnets}"]
  *   azs                             = ["${module.vpc.availability_zones}"]
  *   replica_count                   = "1"
  *   security_groups                 = ["${aws_security_group.allow_all.id}"]
  *   instance_type                   = "db.r4.large"
  *   username                        = "root"
  *   password                        = "changeme"
  *   backup_retention_period         = "5"
  *   final_snapshot_identifier       = "final-db-snapshot-prod"
  *   storage_encrypted               = "true"
  *   apply_immediately               = "true"
  *   monitoring_interval             = "10"
  *   cw_alarms                       = true
  *   cw_sns_topic                    = "${aws_sns_topic.db_alarms_postgres96.id}"
  *   db_parameter_group_name         = "${aws_db_parameter_group.aurora_db_postgres96_parameter_group.id}"
  *   db_cluster_parameter_group_name = "${aws_rds_cluster_parameter_group.aurora_cluster_postgres96_parameter_group.id}"
  * }
  *
  * resource "aws_db_parameter_group" "aurora_db_postgres96_parameter_group" {
  *   name        = "test-aurora-db-postgres96-parameter-group"
  *   family      = "aurora-postgresql9.6"
  *   description = "test-aurora-db-postgres96-parameter-group"
  * }
  *
  * resource "aws_rds_cluster_parameter_group" "aurora_cluster_postgres96_parameter_group" {
  *   name        = "test-aurora-postgres96-cluster-parameter-group"
  *   family      = "aurora-postgresql9.6"
  *   description = "test-aurora-postgres96-cluster-parameter-group"
  * }
  * ```
  */

// DB Subnet Group creation
resource "aws_db_subnet_group" "main" {
  name        = "${var.name}"
  description = "Group of DB subnets"
  subnet_ids  = ["${var.subnets}"]

  tags {
    envname = "${var.envname}"
    envtype = "${var.envtype}"
  }
}

# Random string to use as master password unless one is specified
resource "random_id" "master_password" {
  byte_length = 10
}

// Create single DB instance
resource "aws_rds_cluster_instance" "cluster_instance_0" {
  identifier                   = "${var.identifier_prefix != "" ? format("%s-node-0", var.identifier_prefix) : format("%s-aurora-node-0", var.envname)}"
  cluster_identifier           = "${aws_rds_cluster.default.id}"
  engine                       = "${var.engine}"
  engine_version               = "${var.engine-version}"
  instance_class               = "${var.instance_type}"
  publicly_accessible          = "${var.publicly_accessible}"
  db_subnet_group_name         = "${aws_db_subnet_group.main.name}"
  db_parameter_group_name      = "${var.db_parameter_group_name}"
  preferred_maintenance_window = "${var.preferred_maintenance_window}"
  apply_immediately            = "${var.apply_immediately}"
  monitoring_role_arn          = "${join("", aws_iam_role.rds-enhanced-monitoring.*.arn)}"
  monitoring_interval          = "${var.monitoring_interval}"
  auto_minor_version_upgrade   = "${var.auto_minor_version_upgrade}"
  promotion_tier               = "0"

  tags {
    envname = "${var.envname}"
    envtype = "${var.envtype}"
  }
}

// Create 'n' number of additional DB instance(s) in same cluster
resource "aws_rds_cluster_instance" "cluster_instance_n" {
  depends_on                   = ["aws_rds_cluster_instance.cluster_instance_0"]
  count                        = "${var.replica_scale_enabled ? var.replica_scale_min : var.replica_count}"
  engine                       = "${var.engine}"
  engine_version               = "${var.engine-version}"
  identifier                   = "${var.identifier_prefix != "" ? format("%s-node-%d", var.identifier_prefix, count.index + 1) : format("%s-aurora-node-%d", var.envname, count.index + 1)}"
  cluster_identifier           = "${aws_rds_cluster.default.id}"
  instance_class               = "${var.instance_type}"
  publicly_accessible          = "${var.publicly_accessible}"
  db_subnet_group_name         = "${aws_db_subnet_group.main.name}"
  db_parameter_group_name      = "${var.db_parameter_group_name}"
  preferred_maintenance_window = "${var.preferred_maintenance_window}"
  apply_immediately            = "${var.apply_immediately}"
  monitoring_role_arn          = "${join("", aws_iam_role.rds-enhanced-monitoring.*.arn)}"
  monitoring_interval          = "${var.monitoring_interval}"
  auto_minor_version_upgrade   = "${var.auto_minor_version_upgrade}"
  promotion_tier               = "${count.index + 1}"

  tags {
    envname = "${var.envname}"
    envtype = "${var.envtype}"
  }
}

// Create DB Cluster
resource "aws_rds_cluster" "default" {
  cluster_identifier = "${var.identifier_prefix != "" ? format("%s-cluster", var.identifier_prefix) : format("%s-aurora-cluster", var.envname)}"
  availability_zones = ["${var.azs}"]
  engine             = "${var.engine}"

  engine_version                  = "${var.engine-version}"
  master_username                 = "${var.username}"
  master_password                 = "${local.master_password}"
  final_snapshot_identifier       = "${var.final_snapshot_identifier}-${random_id.server.hex}"
  skip_final_snapshot             = "${var.skip_final_snapshot}"
  backup_retention_period         = "${var.backup_retention_period}"
  preferred_backup_window         = "${var.preferred_backup_window}"
  preferred_maintenance_window    = "${var.preferred_maintenance_window}"
  port                            = "${local.port}"
  db_subnet_group_name            = "${aws_db_subnet_group.main.name}"
  vpc_security_group_ids          = ["${var.security_groups}"]
  snapshot_identifier             = "${var.snapshot_identifier}"
  storage_encrypted               = "${var.storage_encrypted}"
  apply_immediately               = "${var.apply_immediately}"
  db_cluster_parameter_group_name = "${var.db_cluster_parameter_group_name}"
}

// Geneate an ID when an environment is initialised
resource "random_id" "server" {
  keepers = {
    id = "${aws_db_subnet_group.main.name}"
  }

  byte_length = 10
}

// IAM Role + Policy attach for Enhanced Monitoring
data "aws_iam_policy_document" "monitoring-rds-assume-role-policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["monitoring.rds.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "rds-enhanced-monitoring" {
  count              = "${var.monitoring_interval > 0 ? 1 : 0}"
  name               = "rds-enhanced-monitoring-${var.envname}"
  assume_role_policy = "${data.aws_iam_policy_document.monitoring-rds-assume-role-policy.json}"
}

resource "aws_iam_role_policy_attachment" "rds-enhanced-monitoring-policy-attach" {
  count      = "${var.monitoring_interval > 0 ? 1 : 0}"
  role       = "${aws_iam_role.rds-enhanced-monitoring.name}"
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonRDSEnhancedMonitoringRole"
}

// Autoscaling
resource "aws_appautoscaling_target" "autoscaling" {
  count              = "${var.replica_scale_enabled ? 1 : 0}"
  max_capacity       = "${var.replica_scale_max}"
  min_capacity       = "${var.replica_scale_min}"
  resource_id        = "cluster:${aws_rds_cluster.default.cluster_identifier}"
  scalable_dimension = "rds:cluster:ReadReplicaCount"
  service_namespace  = "rds"
}

resource "aws_appautoscaling_policy" "autoscaling" {
  count              = "${var.replica_scale_enabled ? 1 : 0}"
  depends_on         = ["aws_appautoscaling_target.autoscaling"]
  name               = "target-metric"
  policy_type        = "TargetTrackingScaling"
  resource_id        = "cluster:${aws_rds_cluster.default.cluster_identifier}"
  scalable_dimension = "rds:cluster:ReadReplicaCount"
  service_namespace  = "rds"

  target_tracking_scaling_policy_configuration {
    predefined_metric_specification {
      predefined_metric_type = "RDSReaderAverageCPUUtilization"
    }

    scale_in_cooldown  = "${var.replica_scale_in_cooldown}"
    scale_out_cooldown = "${var.replica_scale_out_cooldown}"
    target_value       = "${var.replica_scale_cpu}"
  }
}
