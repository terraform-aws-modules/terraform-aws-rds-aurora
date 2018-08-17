variable "name" {
  type        = "string"
  description = "Name given resources"
}

variable "subnets" {
  type        = "list"
  description = "List of subnet IDs to use"
}

variable "identifier_prefix" {
  type        = "string"
  default     = ""
  description = "Prefix for cluster and instance identifier"
}

variable "replica_count" {
  type        = "string"
  default     = 1
  description = "Number of reader nodes to create.  If `replica_scale_enable` is `true`, the value of `replica_scale_min` is used instead."
}

variable "allowed_security_groups" {
  type        = "list"
  default     = []
  description = "A list of Security Group ID's to allow access to."
}

variable "vpc_id" {
  description = "VPC ID"
}

variable "availability_zones" {
  type        = "list"
  default     = []
  description = "Availability zones for the cluster. Must 3 or less"
}

variable "instance_type" {
  type        = "string"
  default     = "db.r4.large"
  description = "Instance type to use"
}

variable "publicly_accessible" {
  type        = "string"
  default     = "false"
  description = "Whether the DB should have a public IP address"
}

variable "username" {
  default     = "root"
  description = "Master DB username"
}

variable "password" {
  type        = "string"
  default     = ""
  description = "Master DB password"
}

variable "final_snapshot_identifier_prefix" {
  type        = "string"
  default     = "final"
  description = "The prefix name to use when creating a final snapshot on cluster destroy, appends a random 8 digits to name to ensure it's unique too."
}

variable "skip_final_snapshot" {
  type        = "string"
  default     = "false"
  description = "Should a final snapshot be created on cluster destroy"
}

variable "backup_retention_period" {
  type        = "string"
  default     = "7"
  description = "How long to keep backups for (in days)"
}

variable "preferred_backup_window" {
  type        = "string"
  default     = "02:00-03:00"
  description = "When to perform DB backups"
}

variable "preferred_maintenance_window" {
  type        = "string"
  default     = "sun:05:00-sun:06:00"
  description = "When to perform DB maintenance"
}

variable "port" {
  type        = "string"
  default     = ""
  description = "The port on which to accept connections"
}

variable "apply_immediately" {
  type        = "string"
  default     = "false"
  description = "Determines whether or not any DB modifications are applied immediately, or during the maintenance window"
}

variable "monitoring_interval" {
  type        = "string"
  default     = 0
  description = "The interval (seconds) between points when Enhanced Monitoring metrics are collected"
}

variable "auto_minor_version_upgrade" {
  type        = "string"
  default     = "true"
  description = "Determines whether minor engine upgrades will be performed automatically in the maintenance window"
}

variable "db_parameter_group_name" {
  type        = "string"
  default     = "default.aurora5.6"
  description = "The name of a DB parameter group to use"
}

variable "db_cluster_parameter_group_name" {
  type        = "string"
  default     = "default.aurora5.6"
  description = "The name of a DB Cluster parameter group to use"
}

variable "snapshot_identifier" {
  type        = "string"
  default     = ""
  description = "DB snapshot to create this database from"
}

variable "storage_encrypted" {
  type        = "string"
  default     = "true"
  description = "Specifies whether the underlying storage layer should be encrypted"
}

variable "kms_key_id" {
  type        = "string"
  default     = ""
  description = "The ARN for the KMS encryption key if one is set to the cluster."
}

variable "cw_alarms" {
  type        = "string"
  default     = false
  description = "Whether to enable CloudWatch alarms - requires `cw_sns_topic` is specified"
}

variable "cw_sns_topic" {
  type        = "string"
  default     = "false"
  description = "An SNS topic to publish CloudWatch alarms to"
}

variable "cw_max_conns" {
  type        = "string"
  default     = "500"
  description = "Connection count beyond which to trigger a CloudWatch alarm"
}

variable "cw_max_cpu" {
  type        = "string"
  default     = "85"
  description = "CPU threshold above which to alarm"
}

variable "cw_max_disk_queue_depth" {
  type        = "string"
  default     = "20"
  description = "Disk queue threshold above which to alarm"
}

variable "cw_max_replica_lag" {
  type        = "string"
  default     = "2000"
  description = "Maximum Aurora replica lag in milliseconds above which to alarm"
}

variable "engine" {
  type        = "string"
  default     = "aurora"
  description = "Aurora database engine type, currently aurora, aurora-mysql or aurora-postgresql"
}

variable "engine-version" {
  type        = "string"
  default     = "5.6.10a"
  description = "Aurora database engine version."
}

variable "replica_scale_enabled" {
  type        = "string"
  default     = false
  description = "Whether to enable autoscaling for RDS Aurora (MySQL) read replicas"
}

variable "replica_scale_max" {
  type        = "string"
  default     = "0"
  description = "Maximum number of replicas to allow scaling for"
}

variable "replica_scale_min" {
  type        = "string"
  default     = "2"
  description = "Maximum number of replicas to allow scaling for"
}

variable "replica_scale_cpu" {
  type        = "string"
  default     = "70"
  description = "CPU usage to trigger autoscaling at"
}

variable "replica_scale_in_cooldown" {
  type        = "string"
  default     = "300"
  description = "Cooldown in seconds before allowing further scaling operations after a scale in"
}

variable "replica_scale_out_cooldown" {
  type        = "string"
  default     = "300"
  description = "Cooldown in seconds before allowing further scaling operations after a scale out"
}

variable "route53_zone_id" {
  type        = "string"
  default     = ""
  description = "If specified a route53 record will be created"
}

variable "route53_record_appendix" {
  type        = "string"
  default     = ".rds"
  description = "Will be appended to the route53 record. Only used if route53_zone_id is passed also"
}

variable "route53_record_ttl" {
  type        = "string"
  default     = 60
  description = "TTL of route53 record. Only used if route53_zone_id is passed also"
}

variable "tags" {
  description = "A map of tags to add to all resources."
  type        = "map"
  default     = {}
}

variable "performance_insights_enabled" {
  type        = "string"
  default     = "false"
  description = "Specifies whether Performance Insights is enabled or not."
}

variable "performance_insights_kms_key_id" {
  type        = "string"
  default     = ""
  description = "The ARN for the KMS key to encrypt Performance Insights data."
}
