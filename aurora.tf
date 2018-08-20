resource "aws_db_subnet_group" "main" {
  name        = "${var.name}"
  description = "For Aurora cluster ${var.name}"
  subnet_ids  = ["${var.subnets}"]
  tags        = "${merge(var.tags, map("Name", "aurora-${var.name}"))}"
}

# Random string to use as master password unless one is specified
resource "random_id" "master_password" {
  byte_length = 10
}

resource "aws_rds_cluster" "default" {
  cluster_identifier              = "${var.name}"
  availability_zones              = ["${var.availability_zones}"]
  engine                          = "${var.engine}"
  engine_version                  = "${var.engine-version}"
  kms_key_id                      = "${var.kms_key_id}"
  master_username                 = "${var.username}"
  master_password                 = "${local.master_password}"
  final_snapshot_identifier       = "${var.final_snapshot_identifier_prefix}-${var.name}-${random_id.snapshot_identifier.hex}"
  skip_final_snapshot             = "${var.skip_final_snapshot}"
  backup_retention_period         = "${var.backup_retention_period}"
  preferred_backup_window         = "${var.preferred_backup_window}"
  preferred_maintenance_window    = "${var.preferred_maintenance_window}"
  port                            = "${local.port}"
  db_subnet_group_name            = "${aws_db_subnet_group.main.name}"
  vpc_security_group_ids          = ["${aws_security_group.default.id}"]
  snapshot_identifier             = "${var.snapshot_identifier}"
  storage_encrypted               = "${var.storage_encrypted}"
  apply_immediately               = "${var.apply_immediately}"
  db_cluster_parameter_group_name = "${var.db_cluster_parameter_group_name}"
  tags                            = "${var.tags}"
}

resource "aws_rds_cluster_instance" "cluster_instance" {
  count                           = "${var.replica_scale_enabled ? var.replica_scale_min : var.replica_count}"
  identifier                      = "${var.name}-${count.index + 1}"
  cluster_identifier              = "${aws_rds_cluster.default.id}"
  engine                          = "${var.engine}"
  engine_version                  = "${var.engine-version}"
  instance_class                  = "${var.instance_type}"
  publicly_accessible             = "${var.publicly_accessible}"
  db_subnet_group_name            = "${aws_db_subnet_group.main.name}"
  db_parameter_group_name         = "${var.db_parameter_group_name}"
  preferred_maintenance_window    = "${var.preferred_maintenance_window}"
  apply_immediately               = "${var.apply_immediately}"
  monitoring_role_arn             = "${join("", aws_iam_role.rds-enhanced-monitoring.*.arn)}"
  monitoring_interval             = "${var.monitoring_interval}"
  auto_minor_version_upgrade      = "${var.auto_minor_version_upgrade}"
  promotion_tier                  = "${count.index + 1}"
  performance_insights_enabled    = "${var.performance_insights_enabled}"
  performance_insights_kms_key_id = "${var.performance_insights_kms_key_id}"
  tags                            = "${var.tags}"
}

resource "random_id" "snapshot_identifier" {
  keepers = {
    id = "${var.name}"
  }

  byte_length = 4
}

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
  name               = "rds-enhanced-monitoring-${var.name}"
  assume_role_policy = "${data.aws_iam_policy_document.monitoring-rds-assume-role-policy.json}"
}

resource "aws_iam_role_policy_attachment" "rds-enhanced-monitoring-policy-attach" {
  count      = "${var.monitoring_interval > 0 ? 1 : 0}"
  role       = "${aws_iam_role.rds-enhanced-monitoring.name}"
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonRDSEnhancedMonitoringRole"
}

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
