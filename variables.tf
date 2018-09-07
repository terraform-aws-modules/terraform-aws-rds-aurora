variable "name" {
  description = "Name given resources"
}

variable "subnets" {
  description = "List of subnet IDs to use"
  type        = "list"
}

variable "identifier_prefix" {
  description = "Prefix for cluster and instance identifier"
  default     = ""
}

variable "replica_count" {
  description = "Number of reader nodes to create.  If `replica_scale_enable` is `true`, the value of `replica_scale_min` is used instead."
  default     = 1
}

variable "allowed_security_groups" {
  description = "A list of Security Group ID's to allow access to."
  default     = []
}

variable "vpc_id" {
  description = "VPC ID"
}

variable "availability_zones" {
  description = "Availability zones for the cluster. Must 3 or less"
  default     = []
}

variable "instance_type" {
  description = "Instance type to use"
}

variable "publicly_accessible" {
  description = "Whether the DB should have a public IP address"
  default     = "false"
}

variable "username" {
  description = "Master DB username"
  default     = "root"
}

variable "password" {
  description = "Master DB password"
  default     = ""
}

variable "final_snapshot_identifier_prefix" {
  description = "The prefix name to use when creating a final snapshot on cluster destroy, appends a random 8 digits to name to ensure it's unique too."
  default     = "final"
}

variable "skip_final_snapshot" {
  description = "Should a final snapshot be created on cluster destroy"
  default     = "false"
}

variable "backup_retention_period" {
  description = "How long to keep backups for (in days)"
  default     = "7"
}

variable "preferred_backup_window" {
  description = "When to perform DB backups"
  default     = "02:00-03:00"
}

variable "preferred_maintenance_window" {
  description = "When to perform DB maintenance"
  default     = "sun:05:00-sun:06:00"
}

variable "port" {
  description = "The port on which to accept connections"
  default     = ""
}

variable "apply_immediately" {
  description = "Determines whether or not any DB modifications are applied immediately, or during the maintenance window"
  default     = "false"
}

variable "monitoring_interval" {
  description = "The interval (seconds) between points when Enhanced Monitoring metrics are collected"
  default     = 0
}

variable "auto_minor_version_upgrade" {
  description = "Determines whether minor engine upgrades will be performed automatically in the maintenance window"
  default     = "true"
}

variable "db_parameter_group_name" {
  description = "The name of a DB parameter group to use"
  default     = "default.aurora5.6"
}

variable "db_cluster_parameter_group_name" {
  description = "The name of a DB Cluster parameter group to use"
  default     = "default.aurora5.6"
}

variable "snapshot_identifier" {
  description = "DB snapshot to create this database from"
  default     = ""
}

variable "storage_encrypted" {
  description = "Specifies whether the underlying storage layer should be encrypted"
  default     = "true"
}

variable "kms_key_id" {
  description = "The ARN for the KMS encryption key if one is set to the cluster."
  default     = ""
}

variable "engine" {
  description = "Aurora database engine type, currently aurora, aurora-mysql or aurora-postgresql"
  default     = "aurora"
}

variable "engine_version" {
  description = "Aurora database engine version."
  default     = "5.6.10a"
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
