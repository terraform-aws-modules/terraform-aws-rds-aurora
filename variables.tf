variable "name" {
  description = "Name given resources"
}

variable "subnets" {
  description = "List of subnet IDs to use"
  type        = "list"
}

variable "replica_count" {
  description = "Number of reader nodes to create.  If `replica_scale_enable` is `true`, the value of `replica_scale_min` is used instead."
  default     = 1
}

variable "allowed_security_groups" {
  description = "A list of Security Group ID's to allow access to."
  default     = []
}

variable "allowed_security_groups_count" {
  description = "The number of Security Groups being added, terraform doesn't let us use length() in a count field"
  default     = 0
}

variable "allowed_cidr_blocks" {
  description = "A list of CIDR blocks which are allowed to access the database"
  type        = "list"
  default     = []
}

variable "allowed_cidr_blocks_count" {
  description = "The number of CIDR blocks being added, terraform doesn't let us use length() in a count field"
  default     = 0
}

variable "vpc_id" {
  description = "VPC ID"
}

variable "instance_type" {
  description = "Instance type to use"
}

variable "publicly_accessible" {
  description = "Whether the DB should have a public IP address"
  default     = "false"
}

variable "database_name" {
  description = "Name for an automatically created database on cluster creation"
  default     = ""
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

variable "deletion_protection" {
  description = "If the DB instance should have deletion protection enabled"
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

variable "scaling_configuration" {
  description = "List of nested attributes with scaling properties. Only valid when engine_mode is set to `serverless`"
  default     = []
  type        = "list"
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
  description = "Whether to enable autoscaling for RDS Aurora (MySQL) read replicas"
  default     = false
}

variable "replica_scale_max" {
  description = "Maximum number of replicas to allow scaling for"
  default     = "0"
}

variable "replica_scale_min" {
  description = "Minimum number of replicas to allow scaling for"
  default     = "2"
}

variable "replica_scale_cpu" {
  description = "CPU usage to trigger autoscaling at"
  default     = "70"
}

variable "replica_scale_in_cooldown" {
  description = "Cooldown in seconds before allowing further scaling operations after a scale in"
  default     = "300"
}

variable "replica_scale_out_cooldown" {
  description = "Cooldown in seconds before allowing further scaling operations after a scale out"
  default     = "300"
}

variable "tags" {
  description = "A map of tags to add to all resources."
  type        = "map"
  default     = {}
}

variable "performance_insights_enabled" {
  description = "Specifies whether Performance Insights is enabled or not."
  default     = false
}

variable "performance_insights_kms_key_id" {
  description = "The ARN for the KMS key to encrypt Performance Insights data."
  default     = ""
}

variable "iam_database_authentication_enabled" {
  description = "Specifies whether IAM Database authentication should be enabled or not. Not all versions and instances are supported. Refer to the AWS documentation to see which versions are supported."
  default     = false
}

variable "enabled_cloudwatch_logs_exports" {
  description = "List of log types to export to cloudwatch"
  type        = "list"
  default     = []
}

variable "global_cluster_identifier" {
  description = "The global cluster identifier specified on aws_rds_global_cluster"
  default     = ""
}

variable "engine_mode" {
  description = "The database engine mode. Valid values: global, parallelquery, provisioned, serverless."
  default     = "provisioned"
}

variable "replication_source_identifier" {
  description = "ARN of a source DB cluster or DB instance if this DB cluster is to be created as a Read Replica."
  default     = ""
}

variable "source_region" {
  description = "The source region for an encrypted replica DB cluster."
  default     = ""
}

variable "vpc_security_group_ids" {
  description = "List of VPC security groups to associate to the cluster in addition to the SG we create in this module"
  type        = "list"
  default     = []
}

variable "backtrack_window" {
  description = "The target backtrack window, in seconds. Only available for aurora engine currently. To disable backtracking, set this value to 0. Defaults to 0. Must be between 0 and 259200 (72 hours)"
  default     = "0"
}

variable "copy_tags_to_snapshot" {
  description = "Indicates whether to copy all of the user-defined tags from the DB instance to snapshots of the DB instance."
  default     = false
}

variable "ca_cert_identifier" {
  description = "Specifies the identifier of the CA certificate for the DB instance. Possible values `rds-ca-2015` | `rds-ca-2019`"
  default     = "rds-ca-2015"
}
