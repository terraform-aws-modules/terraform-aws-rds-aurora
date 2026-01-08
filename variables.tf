variable "create" {
  description = "Whether cluster should be created (affects nearly all resources)"
  type        = bool
  default     = true
}

variable "region" {
  description = "Region where the resource(s) will be managed. Defaults to the Region set in the provider configuration"
  type        = string
  default     = null
}

variable "name" {
  description = "Name used across resources created"
  type        = string
  default     = ""
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}

################################################################################
# DB Subnet Group
################################################################################

variable "create_db_subnet_group" {
  description = "Determines whether to create the database subnet group or use existing"
  type        = bool
  default     = false
}

variable "db_subnet_group_name" {
  description = "The name of the subnet group name (existing or created)"
  type        = string
  default     = ""
}

variable "subnets" {
  description = "List of subnet IDs used by database subnet group created"
  type        = list(string)
  default     = []
}

################################################################################
# Cluster
################################################################################

variable "is_primary_cluster" {
  description = "Determines whether cluster is primary cluster with writer instance (set to `false` for global cluster and replica clusters)"
  type        = bool
  default     = true
}

variable "cluster_use_name_prefix" {
  description = "Whether to use `name` as a prefix for the cluster"
  type        = bool
  default     = false
}

variable "allocated_storage" {
  description = "The amount of storage in gibibytes (GiB) to allocate to each DB instance in the Multi-AZ DB cluster. (This setting is required to create a Multi-AZ DB cluster)"
  type        = number
  default     = null
}

variable "allow_major_version_upgrade" {
  description = "Enable to allow major engine version upgrades when changing engine versions. Defaults to `false`"
  type        = bool
  default     = false
}

variable "apply_immediately" {
  description = "Specifies whether any cluster modifications are applied immediately, or during the next maintenance window. Default is `false`"
  type        = bool
  default     = null
}

variable "availability_zones" {
  description = "List of EC2 Availability Zones for the DB cluster storage where DB cluster instances can be created. RDS automatically assigns 3 AZs if less than 3 AZs are configured, which will show as a difference requiring resource recreation next Terraform apply"
  type        = list(string)
  default     = null
}

variable "backup_retention_period" {
  description = "The days to retain backups for"
  type        = number
  default     = null
}

variable "backtrack_window" {
  description = "The target backtrack window, in seconds. Only available for `aurora` engine currently. To disable backtracking, set this value to 0. Must be between 0 and 259200 (72 hours)"
  type        = number
  default     = null
}

variable "cluster_ca_cert_identifier" {
  description = "The CA certificate identifier to use for the DB cluster's server certificate. Currently only supported for multi-az DB clusters"
  type        = string
  default     = null
}

variable "cluster_members" {
  description = "List of RDS Instances that are a part of this cluster"
  type        = list(string)
  default     = null
}

variable "cluster_scalability_type" {
  description = "Specifies the scalability mode of the Aurora DB cluster. When set to limitless, the cluster operates as an Aurora Limitless Database. When set to standard (the default), the cluster uses normal DB instance creation. Valid values: limitless, standard"
  type        = string
  default     = null
}

variable "cluster_performance_insights_enabled" {
  description = "Enables Performance Insights for the RDS Cluster"
  type        = bool
  default     = null
}

variable "cluster_performance_insights_kms_key_id" {
  description = "Specifies the KMS Key ID to encrypt Performance Insights data. If not specified, the default RDS KMS key will be used (aws/rds)"
  type        = string
  default     = null
}

variable "cluster_performance_insights_retention_period" {
  description = "Specifies the amount of time to retain performance insights data for. Defaults to 7 days if Performance Insights are enabled. Valid values are 7, month * 31 (where month is a number of months from 1-23), and 731"
  type        = number
  default     = null
}

variable "cluster_monitoring_interval" {
  description = "Interval, in seconds, between points when Enhanced Monitoring metrics are collected for the DB cluster. To turn off collecting Enhanced Monitoring metrics, specify 0. Valid Values: 0, 1, 5, 10, 15, 30, 60"
  type        = number
  default     = 0
}

variable "copy_tags_to_snapshot" {
  description = "Copy all Cluster `tags` to snapshots"
  type        = bool
  default     = true
}

variable "database_insights_mode" {
  description = "The mode of Database Insights to enable for the DB cluster. Valid values: standard, advanced"
  type        = string
  default     = null
}

variable "database_name" {
  description = "Name for an automatically created database on cluster creation"
  type        = string
  default     = null
}

variable "cluster_instance_class" {
  description = "The compute and memory capacity of each DB instance in the Multi-AZ DB cluster (not all DB instance classes are available in all AWS Regions, or for all database engines)"
  type        = string
  default     = null
}

variable "cluster_db_instance_parameter_group_name" {
  description = "Instance parameter group to associate with all instances of the DB cluster. The `cluster_db_instance_parameter_group_name` is only valid in combination with `allow_major_version_upgrade`"
  type        = string
  default     = null
}

variable "delete_automated_backups" {
  description = "Specifies whether to remove automated backups immediately after the DB cluster is deleted"
  type        = bool
  default     = null
}

variable "deletion_protection" {
  description = "If the DB instance should have deletion protection enabled. The database can't be deleted when this value is set to `true`. The default is `false`"
  type        = bool
  default     = null
}

variable "enable_global_write_forwarding" {
  description = "Whether cluster should forward writes to an associated global cluster. Applied to secondary clusters to enable them to forward writes to an `aws_rds_global_cluster`'s primary cluster"
  type        = bool
  default     = null
}

variable "enable_local_write_forwarding" {
  description = "Whether read replicas can forward write operations to the writer DB instance in the DB cluster. By default, write operations aren't allowed on reader DB instances"
  type        = bool
  default     = null
}

variable "enabled_cloudwatch_logs_exports" {
  description = "Set of log types to export to cloudwatch. If omitted, no logs will be exported. The following log types are supported: `audit`, `error`, `general`, `slowquery`, `postgresql`"
  type        = list(string)
  default     = []
}

variable "enable_http_endpoint" {
  description = "Enable HTTP endpoint (data API). Only valid when engine_mode is set to `serverless`"
  type        = bool
  default     = null
}

variable "engine" {
  description = "The name of the database engine to be used for this DB cluster. Defaults to `aurora`. Valid Values: `aurora`, `aurora-mysql`, `aurora-postgresql`"
  type        = string
  default     = null
}

variable "engine_mode" {
  description = "The database engine mode. Valid values: `global`, `multimaster`, `parallelquery`, `provisioned`, `serverless`. Defaults to: `provisioned`"
  type        = string
  default     = "provisioned"
}

variable "engine_version" {
  description = "The database engine version. Updating this argument results in an outage"
  type        = string
  default     = null
}

variable "engine_lifecycle_support" {
  description = "The life cycle type for this DB instance. This setting is valid for cluster types Aurora DB clusters and Multi-AZ DB clusters. Valid values are `open-source-rds-extended-support`, `open-source-rds-extended-support-disabled`. Default value is `open-source-rds-extended-support`"
  type        = string
  default     = null
}

variable "final_snapshot_identifier" {
  description = "The name of your final DB snapshot when this DB cluster is deleted. If omitted, no final snapshot will be made"
  type        = string
  default     = null
}

variable "global_cluster_identifier" {
  description = "The global cluster identifier specified on `aws_rds_global_cluster`"
  type        = string
  default     = null
}

variable "iam_database_authentication_enabled" {
  description = "Specifies whether or mappings of AWS Identity and Access Management (IAM) accounts to database accounts is enabled"
  type        = bool
  default     = null
}

variable "domain" {
  description = "The ID of the Directory Service Active Directory domain to create the instance in"
  type        = string
  default     = null
}

variable "domain_iam_role_name" {
  description = "(Required if domain is provided) The name of the IAM role to be used when making API calls to the Directory Service"
  type        = string
  default     = null
}

variable "iops" {
  description = "The amount of Provisioned IOPS (input/output operations per second) to be initially allocated for each DB instance in the Multi-AZ DB cluster"
  type        = number
  default     = null
}

variable "kms_key_id" {
  description = "The ARN for the KMS encryption key. When specifying `kms_key_id`, `storage_encrypted` needs to be set to `true`"
  type        = string
  default     = null
}

variable "manage_master_user_password" {
  description = "Set to true to allow RDS to manage the master user password in Secrets Manager. Cannot be set if `master_password_wo` is provided"
  type        = bool
  default     = true
}

variable "master_user_secret_kms_key_id" {
  description = "The Amazon Web Services KMS key identifier is the key ARN, key ID, alias ARN, or alias name for the KMS key"
  type        = string
  default     = null
}

variable "master_password_wo" {
  description = "Write-Only required unless `manage_master_user_password` is set to `true`, a `snapshot_identifier`, `replication_source_identifier`, or unless a `global_cluster_identifier` is provided when the cluster is the \"secondary\" cluster of a global database) Password for the master DB user"
  type        = string
  sensitive   = true
  ephemeral   = true
  default     = null
}

variable "master_password_wo_version" {
  description = "Used together with `master_password_wo` to trigger an update. Increment this value when an update to the `master_password_wo` is required"
  type        = number
  default     = null
}

variable "master_username" {
  description = "Username for the master DB user. Required unless `snapshot_identifier` or `replication_source_identifier` is provided or unless a `global_cluster_identifier` is provided when the cluster is the secondary cluster of a global database"
  type        = string
  default     = null
}

variable "network_type" {
  description = "The type of network stack to use (IPV4 or DUAL)"
  type        = string
  default     = null
}

variable "port" {
  description = "The port on which the DB accepts connections"
  type        = string
  default     = null
}

variable "preferred_backup_window" {
  description = "Daily time range during which automated backups are created if automated backups are enabled using the BackupRetentionPeriod parameter.Time in UTC. Default: A 30-minute window selected at random from an 8-hour block of time per region, e.g. `04:00-09:00`"
  type        = string
  default     = null
}

variable "preferred_maintenance_window" {
  description = "Weekly time range during which system maintenance can occur, in (UTC) e.g., `wed:04:00-wed:04:30`"
  type        = string
  default     = null
}

variable "replication_source_identifier" {
  description = "ARN of a source DB cluster or DB instance if this DB cluster is to be created as a Read Replica"
  type        = string
  default     = null
}

variable "restore_to_point_in_time" {
  description = "Map of nested attributes for cloning Aurora cluster"
  type = object({
    restore_to_time            = optional(string)
    restore_type               = optional(string)
    source_cluster_identifier  = optional(string)
    source_cluster_resource_id = optional(string)
    use_latest_restorable_time = optional(bool)
  })
  default = null
}

variable "s3_import" {
  description = "Configuration map used to restore from a Percona Xtrabackup in S3 (only MySQL is supported)"
  type = object({
    bucket_name           = string
    bucket_prefix         = optional(string)
    ingestion_role        = string
    source_engine_version = string
  })
  default = null
}

variable "scaling_configuration" {
  description = "Map of nested attributes with scaling properties. Only valid when `engine_mode` is set to `serverless`"
  type = object({
    auto_pause               = optional(bool)
    max_capacity             = optional(number)
    min_capacity             = optional(number)
    seconds_before_timeout   = optional(number)
    seconds_until_auto_pause = optional(number)
    timeout_action           = optional(string)
  })
  default = null
}

variable "serverlessv2_scaling_configuration" {
  description = "Map of nested attributes with serverless v2 scaling properties. Only valid when `engine_mode` is set to `provisioned`"
  type = object({
    max_capacity             = number
    min_capacity             = optional(number)
    seconds_until_auto_pause = optional(number)
  })
  default = null
}

variable "skip_final_snapshot" {
  description = "Determines whether a final snapshot is created before the cluster is deleted. If true is specified, no snapshot is created"
  type        = bool
  default     = false
}

variable "snapshot_identifier" {
  description = "Specifies whether or not to create this cluster from a snapshot. You can use either the name or ARN when specifying a DB cluster snapshot, or the ARN when specifying a DB snapshot"
  type        = string
  default     = null
}

variable "source_region" {
  description = "The source region for an encrypted replica DB cluster"
  type        = string
  default     = null
}

variable "storage_encrypted" {
  description = "Specifies whether the DB cluster is encrypted. The default is `true`"
  type        = bool
  default     = true
}

variable "storage_type" {
  description = "Determines the storage type for the DB cluster. Optional for Single-AZ, required for Multi-AZ DB clusters. Valid values for Single-AZ: `aurora`, `\"\"` (default, both refer to Aurora Standard), `aurora-iopt1` (Aurora I/O Optimized). Valid values for Multi-AZ: `io1` (default)"
  type        = string
  default     = null
}

variable "cluster_tags" {
  description = "A map of tags to add to only the cluster. Used for AWS Instance Scheduler tagging"
  type        = map(string)
  default     = {}
}

variable "vpc_security_group_ids" {
  description = "List of VPC security groups to associate to the cluster in addition to the security group created"
  type        = list(string)
  default     = []
}

variable "cluster_timeouts" {
  description = "Create, update, and delete timeout configurations for the cluster"
  type = object({
    create = optional(string)
    update = optional(string)
    delete = optional(string)
  })
  default = null
}

################################################################################
# Cluster Instance(s)
################################################################################

variable "instances" {
  description = "Map of cluster instances and any specific/overriding attributes to be created"
  type = map(object({
    apply_immediately                     = optional(bool)
    auto_minor_version_upgrade            = optional(bool)
    availability_zone                     = optional(string)
    ca_cert_identifier                    = optional(string)
    copy_tags_to_snapshot                 = optional(bool, true)
    custom_iam_instance_profile           = optional(string)
    db_parameter_group_name               = optional(string)
    db_subnet_group_name                  = optional(string)
    identifier                            = optional(string)
    identifier_prefix                     = optional(string)
    instance_class                        = optional(string)
    monitoring_interval                   = optional(number)
    monitoring_role_arn                   = optional(string)
    performance_insights_enabled          = optional(bool)
    performance_insights_kms_key_id       = optional(string)
    performance_insights_retention_period = optional(number)
    preferred_maintenance_window          = optional(string)
    promotion_tier                        = optional(number)
    publicly_accessible                   = optional(bool)
    tags                                  = optional(map(string), {})
  }))
  default  = {}
  nullable = false
}

variable "instances_use_identifier_prefix" {
  description = "Determines whether cluster instance identifiers are used as prefixes"
  type        = bool
  default     = false
}

variable "instance_timeouts" {
  description = "Create, update, and delete timeout configurations for the cluster instance(s)"
  type = object({
    create = optional(string)
    update = optional(string)
    delete = optional(string)
  })
  default = null
}

################################################################################
# Cluster Endpoint(s)
################################################################################

variable "endpoints" {
  description = "Map of additional cluster endpoints and their attributes to be created"
  type = map(object({
    identifier       = string
    type             = string
    excluded_members = optional(list(string))
    static_members   = optional(list(string))
    tags             = optional(map(string), {})
  }))
  default  = {}
  nullable = false
}

################################################################################
# Cluster IAM Role Association(s)
################################################################################

variable "role_associations" {
  description = "Map of IAM roles and supported feature names to associate with the cluster"
  type = map(object({
    feature_name = optional(string)
    role_arn     = string
  }))
  default  = {}
  nullable = false
}

################################################################################
# Enhanced Monitoring
################################################################################

variable "create_monitoring_role" {
  description = "Determines whether to create the IAM role for RDS enhanced monitoring"
  type        = bool
  default     = true
}

variable "monitoring_role_arn" {
  description = "IAM role used by RDS to send enhanced monitoring metrics to CloudWatch"
  type        = string
  default     = ""
}

variable "iam_role_name" {
  description = "Friendly name of the monitoring role"
  type        = string
  default     = null
}

variable "iam_role_use_name_prefix" {
  description = "Determines whether to use `iam_role_name` as is or create a unique name beginning with the `iam_role_name` as the prefix"
  type        = bool
  default     = false
}

variable "iam_role_description" {
  description = "Description of the monitoring role"
  type        = string
  default     = null
}

variable "iam_role_path" {
  description = "Path for the monitoring role"
  type        = string
  default     = null
}

variable "iam_role_permissions_boundary" {
  description = "The ARN of the policy that is used to set the permissions boundary for the monitoring role"
  type        = string
  default     = null
}

variable "iam_role_max_session_duration" {
  description = "Maximum session duration (in seconds) that you want to set for the monitoring role"
  type        = number
  default     = null
}

################################################################################
# Autoscaling
################################################################################

variable "autoscaling_enabled" {
  description = "Determines whether autoscaling of the cluster read replicas is enabled"
  type        = bool
  default     = false
}

variable "autoscaling_max_capacity" {
  description = "Maximum number of read replicas permitted when autoscaling is enabled"
  type        = number
  default     = 2
}

variable "autoscaling_min_capacity" {
  description = "Minimum number of read replicas permitted when autoscaling is enabled"
  type        = number
  default     = 0
}

variable "autoscaling_policy_name" {
  description = "Autoscaling policy name"
  type        = string
  default     = "target-metric"
}

variable "predefined_metric_type" {
  description = "The metric type to scale on. Valid values are `RDSReaderAverageCPUUtilization` and `RDSReaderAverageDatabaseConnections`"
  type        = string
  default     = "RDSReaderAverageCPUUtilization"
}

variable "autoscaling_scale_in_cooldown" {
  description = "Cooldown in seconds before allowing further scaling operations after a scale in"
  type        = number
  default     = 300
}

variable "autoscaling_scale_out_cooldown" {
  description = "Cooldown in seconds before allowing further scaling operations after a scale out"
  type        = number
  default     = 300
}

variable "autoscaling_target_cpu" {
  description = "CPU threshold which will initiate autoscaling"
  type        = number
  default     = 70
}

variable "autoscaling_target_connections" {
  description = "Average number of connections threshold which will initiate autoscaling. Default value is 70% of db.r4/r5/r6g.large's default max_connections"
  type        = number
  default     = 700
}

################################################################################
# Security Group
################################################################################

variable "create_security_group" {
  description = "Determines whether to create security group for RDS cluster"
  type        = bool
  default     = true
}

variable "security_group_name" {
  description = "The security group name. Default value is (`var.name`)"
  type        = string
  default     = ""
}

variable "security_group_use_name_prefix" {
  description = "Determines whether the security group name (`var.name`) is used as a prefix"
  type        = bool
  default     = true
}

variable "security_group_description" {
  description = "The description of the security group. If value is set to empty string it will contain cluster name in the description"
  type        = string
  default     = null
}

variable "vpc_id" {
  description = "ID of the VPC where to create security group"
  type        = string
  default     = ""
}

variable "security_group_ingress_rules" {
  description = "Map of security group ingress rules to add to the security group created"
  type = map(object({
    name = optional(string)

    cidr_ipv4                    = optional(string)
    cidr_ipv6                    = optional(string)
    description                  = optional(string)
    from_port                    = optional(number)
    ip_protocol                  = optional(string, "tcp")
    prefix_list_id               = optional(string)
    referenced_security_group_id = optional(string)
    region                       = optional(string)
    tags                         = optional(map(string), {})
    to_port                      = optional(number)
  }))
  default  = {}
  nullable = false
}

variable "security_group_egress_rules" {
  description = "Map of security group egress rules to add to the security group created"
  type = map(object({
    name = optional(string)

    cidr_ipv4                    = optional(string)
    cidr_ipv6                    = optional(string)
    description                  = optional(string)
    from_port                    = optional(number)
    ip_protocol                  = optional(string, "tcp")
    prefix_list_id               = optional(string)
    referenced_security_group_id = optional(string)
    region                       = optional(string)
    tags                         = optional(map(string), {})
    to_port                      = optional(number)
  }))
  default  = {}
  nullable = false
}

variable "security_group_tags" {
  description = "Additional tags for the security group"
  type        = map(string)
  default     = {}
}

################################################################################
# Cluster Parameter Group
################################################################################

variable "cluster_parameter_group_name" {
  description = "The name of an existing DB cluster parameter group. Required when `cluster_parameter_group` is not provided (`null`)"
  type        = string
  default     = null
}

variable "cluster_parameter_group" {
  description = "Map of nested arguments for the created DB cluster parameter group"
  type = object({
    name            = optional(string)
    use_name_prefix = optional(bool, true)
    description     = optional(string)
    family          = string
    parameters = optional(list(object({
      name         = string
      value        = string
      apply_method = optional(string, "immediate")
    })))
  })
  default = null
}

################################################################################
# DB Parameter Group
################################################################################

variable "db_parameter_group" {
  description = "Map of nested arguments for the created DB parameter group"
  type = object({
    name            = optional(string)
    use_name_prefix = optional(bool, true)
    description     = optional(string)
    family          = string
    parameters = optional(list(object({
      name         = string
      value        = string
      apply_method = optional(string, "immediate")
    })))
  })
  default = null
}

################################################################################
# CloudWatch Log Group
################################################################################

variable "create_cloudwatch_log_group" {
  description = "Determines whether a CloudWatch log group is created for each `enabled_cloudwatch_logs_exports`"
  type        = bool
  default     = false
}

variable "cloudwatch_log_group_retention_in_days" {
  description = "The number of days to retain CloudWatch logs for the DB instance"
  type        = number
  default     = 7
}

variable "cloudwatch_log_group_kms_key_id" {
  description = "The ARN of the KMS Key to use when encrypting log data"
  type        = string
  default     = null
}

variable "cloudwatch_log_group_skip_destroy" {
  description = "Set to true if you do not wish the log group (and any logs it may contain) to be deleted at destroy time, and instead just remove the log group from the Terraform state"
  type        = bool
  default     = null
}

variable "cloudwatch_log_group_class" {
  description = "Specified the log class of the log group. Possible values are: STANDARD or INFREQUENT_ACCESS"
  type        = string
  default     = null
}

variable "cloudwatch_log_group_tags" {
  description = "Additional tags for the CloudWatch log group(s)"
  type        = map(string)
  default     = {}
}

################################################################################
# Cluster Activity Stream
################################################################################

variable "cluster_activity_stream" {
  description = "Map of arguments for the created DB cluster activity stream"
  type = object({
    include_audit_fields = optional(bool, false)
    kms_key_id           = string
    mode                 = string
  })
  default = null
}

################################################################################
# Managed Secret Rotation
################################################################################

variable "manage_master_user_password_rotation" {
  description = "Whether to manage the master user password rotation. By default, false on creation, rotation is managed by RDS. There is not currently a way to disable this on initial creation even when set to false. Setting this value to false after previously having been set to true will disable automatic rotation"
  type        = bool
  default     = false
}

variable "master_user_password_rotate_immediately" {
  description = "Specifies whether to rotate the secret immediately or wait until the next scheduled rotation window"
  type        = bool
  default     = null
}

variable "master_user_password_rotation_automatically_after_days" {
  description = "Specifies the number of days between automatic scheduled rotations of the secret. Either `master_user_password_rotation_automatically_after_days` or `master_user_password_rotation_schedule_expression` must be specified"
  type        = number
  default     = null
}

variable "master_user_password_rotation_duration" {
  description = "The length of the rotation window in hours. For example, 3h for a three hour window"
  type        = string
  default     = null
}

variable "master_user_password_rotation_schedule_expression" {
  description = "A cron() or rate() expression that defines the schedule for rotating your secret. Either `master_user_password_rotation_automatically_after_days` or `master_user_password_rotation_schedule_expression` must be specified"
  type        = string
  default     = null
}

################################################################################
# RDS Shard Group
################################################################################

variable "shard_group" {
  description = "Arguments for the DB shard group to be created"
  type = object({
    compute_redundancy  = optional(number)
    identifier          = string
    max_acu             = number
    min_acu             = optional(number)
    publicly_accessible = optional(bool)
    tags                = optional(map(string), {})
    timeouts = optional(object({
      create = optional(string)
      update = optional(string)
      delete = optional(string)
    }))
  })
  default = null
}

variable "putin_khuylo" {
  description = "Do you agree that Putin doesn't respect Ukrainian sovereignty and territorial integrity? More info: https://en.wikipedia.org/wiki/Putin_khuylo!"
  type        = bool
  default     = true
}
