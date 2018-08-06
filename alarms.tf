resource "aws_cloudwatch_metric_alarm" "alarm_rds_DatabaseConnections_writer" {
  count               = "${var.cw_alarms ? 1 : 0}"
  alarm_name          = "${aws_rds_cluster.default.id}-alarm-rds-writer-DatabaseConnections"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "DatabaseConnections"
  namespace           = "AWS/RDS"
  period              = "60"
  statistic           = "Sum"
  threshold           = "${var.cw_max_conns}"
  alarm_description   = "RDS Maximum connection Alarm for ${aws_rds_cluster.default.id} writer"
  alarm_actions       = ["${var.cw_sns_topic}"]
  ok_actions          = ["${var.cw_sns_topic}"]

  dimensions {
    DBClusterIdentifier = "${aws_rds_cluster.default.id}"
    Role                = "WRITER"
  }
}

resource "aws_cloudwatch_metric_alarm" "alarm_rds_DatabaseConnections_reader" {
  count               = "${var.cw_alarms && var.replica_count > 0 ? 1 : 0}"
  alarm_name          = "${aws_rds_cluster.default.id}-alarm-rds-reader-DatabaseConnections"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "DatabaseConnections"
  namespace           = "AWS/RDS"
  period              = "60"
  statistic           = "Maximum"
  threshold           = "${var.cw_max_conns}"
  alarm_description   = "RDS Maximum connection Alarm for ${aws_rds_cluster.default.id} reader(s)"
  alarm_actions       = ["${var.cw_sns_topic}"]
  ok_actions          = ["${var.cw_sns_topic}"]

  dimensions {
    DBClusterIdentifier = "${aws_rds_cluster.default.id}"
    Role                = "READER"
  }
}

resource "aws_cloudwatch_metric_alarm" "alarm_rds_CPU_writer" {
  count               = "${var.cw_alarms ? 1 : 0}"
  alarm_name          = "${aws_rds_cluster.default.id}-alarm-rds-writer-CPU"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/RDS"
  period              = "60"
  statistic           = "Maximum"
  threshold           = "${var.cw_max_cpu}"
  alarm_description   = "RDS CPU Alarm for ${aws_rds_cluster.default.id} writer"
  alarm_actions       = ["${var.cw_sns_topic}"]
  ok_actions          = ["${var.cw_sns_topic}"]

  dimensions {
    DBClusterIdentifier = "${aws_rds_cluster.default.id}"
    Role                = "WRITER"
  }
}

resource "aws_cloudwatch_metric_alarm" "alarm_rds_CPU_reader" {
  count               = "${var.cw_alarms && var.replica_count > 0 ? 1 : 0}"
  alarm_name          = "${aws_rds_cluster.default.id}-alarm-rds-reader-CPU"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/RDS"
  period              = "60"
  statistic           = "Maximum"
  threshold           = "${var.cw_max_cpu}"
  alarm_description   = "RDS CPU Alarm for ${aws_rds_cluster.default.id} reader(s)"
  alarm_actions       = ["${var.cw_sns_topic}"]
  ok_actions          = ["${var.cw_sns_topic}"]

  dimensions {
    DBClusterIdentifier = "${aws_rds_cluster.default.id}"
    Role                = "READER"
  }
}

resource "aws_cloudwatch_metric_alarm" "alarm_rds_replica_lag" {
  count               = "${var.cw_alarms && var.replica_count > 0 ? 1 : 0}"
  alarm_name          = "${aws_rds_cluster.default.id}-alarm-rds-reader-AuroraReplicaLag"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "5"
  metric_name         = "AuroraReplicaLag"
  namespace           = "AWS/RDS"
  period              = "60"
  statistic           = "Maximum"
  threshold           = "${var.cw_max_replica_lag}"
  alarm_description   = "RDS CPU Alarm for ${aws_rds_cluster.default.id}"
  alarm_actions       = ["${var.cw_sns_topic}"]
  ok_actions          = ["${var.cw_sns_topic}"]

  dimensions {
    DBClusterIdentifier = "${aws_rds_cluster.default.id}"
    Role                = "READER"
  }
}
