data "aws_partition" "current" {}

locals {
  create = var.create && var.putin_khuylo

  port = coalesce(var.port, (var.engine == "aurora-postgresql" || var.engine == "postgres" ? 5432 : 3306))

  backtrack_window = (var.engine == "aurora-mysql" || var.engine == "aurora") && var.engine_mode != "serverless" ? var.backtrack_window : 0

  is_serverless = var.engine_mode == "serverless"
}

################################################################################
# DB Subnet Group
################################################################################

locals {
  internal_db_subnet_group_name = try(coalesce(var.db_subnet_group_name, var.name), "")
  db_subnet_group_name          = var.create_db_subnet_group ? try(aws_db_subnet_group.this[0].name, null) : local.internal_db_subnet_group_name
}

resource "aws_db_subnet_group" "this" {
  count = local.create && var.create_db_subnet_group ? 1 : 0

  region = var.region

  name        = local.internal_db_subnet_group_name
  description = "For Aurora cluster ${var.name}"
  subnet_ids  = var.subnets

  tags = var.tags
}

################################################################################
# Cluster
################################################################################

locals {
  use_master_password         = var.is_primary_cluster && !local.use_managed_master_password
  use_managed_master_password = var.manage_master_user_password && var.global_cluster_identifier == null
}

resource "aws_rds_cluster" "this" {
  count = local.create ? 1 : 0

  region = var.region

  allocated_storage           = var.allocated_storage
  allow_major_version_upgrade = var.allow_major_version_upgrade
  apply_immediately           = var.apply_immediately
  availability_zones          = var.availability_zones
  backup_retention_period     = var.backup_retention_period
  backtrack_window            = local.backtrack_window
  ca_certificate_identifier   = var.cluster_ca_cert_identifier
  cluster_identifier          = var.cluster_use_name_prefix ? null : var.name
  cluster_identifier_prefix   = var.cluster_use_name_prefix ? "${var.name}-" : null
  cluster_members             = var.cluster_members
  cluster_scalability_type    = var.cluster_scalability_type
  copy_tags_to_snapshot       = var.copy_tags_to_snapshot
  database_insights_mode      = var.database_insights_mode
  database_name               = var.is_primary_cluster ? var.database_name : null
  # We are using `allocated_storage` as a proxy to determine if this is RDS multi-az or not
  # https://github.com/hashicorp/terraform-provider-aws/issues/30596#issuecomment-1639292427
  db_cluster_instance_class           = var.allocated_storage != null ? var.cluster_instance_class : null
  db_cluster_parameter_group_name     = local.create_cluster_parameter_group ? aws_rds_cluster_parameter_group.this[0].id : var.cluster_parameter_group_name
  db_instance_parameter_group_name    = var.allow_major_version_upgrade ? var.cluster_db_instance_parameter_group_name : null
  db_subnet_group_name                = local.db_subnet_group_name
  delete_automated_backups            = var.delete_automated_backups
  deletion_protection                 = var.deletion_protection
  enable_global_write_forwarding      = var.enable_global_write_forwarding
  enable_local_write_forwarding       = var.enable_local_write_forwarding
  enabled_cloudwatch_logs_exports     = var.enabled_cloudwatch_logs_exports
  enable_http_endpoint                = var.enable_http_endpoint
  engine                              = var.engine
  engine_mode                         = var.cluster_scalability_type == "limitless" ? "" : var.engine_mode
  engine_version                      = var.engine_version
  engine_lifecycle_support            = var.engine_lifecycle_support
  final_snapshot_identifier           = var.final_snapshot_identifier
  global_cluster_identifier           = var.global_cluster_identifier
  domain                              = var.domain
  domain_iam_role_name                = var.domain_iam_role_name
  iam_database_authentication_enabled = var.iam_database_authentication_enabled
  # iam_roles has been removed from this resource and instead will be used with aws_rds_cluster_role_association below to avoid conflicts per docs
  iops                                  = var.iops
  kms_key_id                            = var.kms_key_id
  manage_master_user_password           = local.use_managed_master_password ? var.manage_master_user_password : null
  master_user_secret_kms_key_id         = local.use_managed_master_password ? var.master_user_secret_kms_key_id : null
  master_password_wo                    = local.use_master_password ? var.master_password_wo : null
  master_password_wo_version            = local.use_master_password ? var.master_password_wo_version : null
  master_username                       = var.is_primary_cluster ? var.master_username : null
  monitoring_interval                   = var.cluster_monitoring_interval
  monitoring_role_arn                   = var.create_monitoring_role && var.cluster_monitoring_interval > 0 ? try(aws_iam_role.rds_enhanced_monitoring[0].arn, null) : var.monitoring_role_arn
  network_type                          = var.network_type
  performance_insights_enabled          = var.cluster_performance_insights_enabled
  performance_insights_kms_key_id       = var.cluster_performance_insights_kms_key_id
  performance_insights_retention_period = var.cluster_performance_insights_retention_period
  port                                  = local.port
  preferred_backup_window               = local.is_serverless ? null : var.preferred_backup_window
  preferred_maintenance_window          = var.preferred_maintenance_window
  replication_source_identifier         = var.replication_source_identifier

  dynamic "restore_to_point_in_time" {
    for_each = var.restore_to_point_in_time != null ? [var.restore_to_point_in_time] : []

    content {
      restore_to_time            = restore_to_point_in_time.value.restore_to_time
      restore_type               = restore_to_point_in_time.value.restore_type
      source_cluster_identifier  = restore_to_point_in_time.value.source_cluster_identifier
      source_cluster_resource_id = restore_to_point_in_time.value.source_cluster_resource_id
      use_latest_restorable_time = restore_to_point_in_time.value.use_latest_restorable_time
    }
  }

  dynamic "s3_import" {
    for_each = var.s3_import != null && !local.is_serverless ? [var.s3_import] : []

    content {
      bucket_name           = s3_import.value.bucket_name
      bucket_prefix         = s3_import.value.bucket_prefix
      ingestion_role        = s3_import.value.ingestion_role
      source_engine         = "mysql"
      source_engine_version = s3_import.value.source_engine_version
    }
  }

  dynamic "scaling_configuration" {
    for_each = var.scaling_configuration != null && local.is_serverless ? [var.scaling_configuration] : []

    content {
      auto_pause               = scaling_configuration.value.auto_pause
      max_capacity             = scaling_configuration.value.max_capacity
      min_capacity             = scaling_configuration.value.min_capacity
      seconds_before_timeout   = scaling_configuration.value.seconds_before_timeout
      seconds_until_auto_pause = scaling_configuration.value.seconds_until_auto_pause
      timeout_action           = scaling_configuration.value.timeout_action
    }
  }

  dynamic "serverlessv2_scaling_configuration" {
    for_each = var.serverlessv2_scaling_configuration != null && var.engine_mode == "provisioned" ? [var.serverlessv2_scaling_configuration] : []

    content {
      max_capacity             = serverlessv2_scaling_configuration.value.max_capacity
      min_capacity             = serverlessv2_scaling_configuration.value.min_capacity
      seconds_until_auto_pause = serverlessv2_scaling_configuration.value.seconds_until_auto_pause
    }
  }

  skip_final_snapshot    = var.skip_final_snapshot
  snapshot_identifier    = var.snapshot_identifier
  source_region          = var.source_region
  storage_encrypted      = var.storage_encrypted
  storage_type           = var.storage_type
  tags                   = merge(var.tags, var.cluster_tags)
  vpc_security_group_ids = compact(concat(aws_security_group.this[*].id, var.vpc_security_group_ids))

  dynamic "timeouts" {
    for_each = var.cluster_timeouts != null ? [var.cluster_timeouts] : []

    content {
      create = timeouts.value.create
      update = timeouts.value.update
      delete = timeouts.value.delete
    }
  }

  lifecycle {
    ignore_changes = [
      # See https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/rds_cluster#replication_source_identifier
      # Since this is used either in read-replica clusters or global clusters, this should be acceptable to specify
      replication_source_identifier,
      # See docs here https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/rds_global_cluster#new-global-cluster-from-existing-db-cluster
      global_cluster_identifier,
      snapshot_identifier,
    ]
  }

  depends_on = [aws_cloudwatch_log_group.this]
}

################################################################################
# Cluster Instance(s)
################################################################################

resource "aws_rds_cluster_instance" "this" {
  for_each = { for k, v in var.instances : k => v if local.create && !local.is_serverless }

  region = var.region

  apply_immediately                     = try(coalesce(each.value.apply_immediately, var.apply_immediately), null)
  auto_minor_version_upgrade            = each.value.auto_minor_version_upgrade
  availability_zone                     = each.value.availability_zone
  ca_cert_identifier                    = try(coalesce(each.value.ca_cert_identifier, var.cluster_ca_cert_identifier), null)
  cluster_identifier                    = aws_rds_cluster.this[0].id
  copy_tags_to_snapshot                 = try(coalesce(each.value.copy_tags_to_snapshot, var.copy_tags_to_snapshot), null)
  custom_iam_instance_profile           = each.value.custom_iam_instance_profile
  db_parameter_group_name               = local.create_db_parameter_group ? aws_db_parameter_group.this[0].id : each.value.db_parameter_group_name
  db_subnet_group_name                  = local.db_subnet_group_name
  engine                                = var.engine
  engine_version                        = var.engine_version
  identifier                            = var.instances_use_identifier_prefix ? null : try(coalesce(each.value.identifier, "${var.name}-${each.key}"))
  identifier_prefix                     = var.instances_use_identifier_prefix ? try(coalesce(each.value.identifier_prefix, "${var.name}-${each.key}-")) : null
  instance_class                        = try(coalesce(each.value.instance_class, var.cluster_instance_class), null)
  monitoring_interval                   = try(coalesce(each.value.monitoring_interval, var.cluster_monitoring_interval), null)
  monitoring_role_arn                   = try(aws_iam_role.rds_enhanced_monitoring[0].arn, each.value.monitoring_role_arn)
  performance_insights_enabled          = try(coalesce(each.value.performance_insights_enabled, var.cluster_performance_insights_enabled), null)
  performance_insights_kms_key_id       = try(coalesce(each.value.performance_insights_kms_key_id, var.cluster_performance_insights_kms_key_id), null)
  performance_insights_retention_period = try(coalesce(each.value.performance_insights_retention_period, var.cluster_performance_insights_retention_period), null)
  # preferred_backup_window - is set at the cluster level and will error if provided here
  preferred_maintenance_window = try(coalesce(each.value.preferred_maintenance_window, var.preferred_maintenance_window), null)
  promotion_tier               = each.value.promotion_tier
  publicly_accessible          = each.value.publicly_accessible
  tags                         = merge(var.tags, each.value.tags)

  dynamic "timeouts" {
    for_each = var.instance_timeouts != null ? [var.instance_timeouts] : []

    content {
      create = timeouts.value.create
      update = timeouts.value.update
      delete = timeouts.value.delete
    }
  }

  lifecycle {
    create_before_destroy = true
  }
}

################################################################################
# Cluster Endpoint(s)
################################################################################

resource "aws_rds_cluster_endpoint" "this" {
  for_each = { for k, v in var.endpoints : k => v if local.create && !local.is_serverless }

  region = var.region

  cluster_endpoint_identifier = each.value.identifier
  cluster_identifier          = aws_rds_cluster.this[0].id
  custom_endpoint_type        = each.value.type
  excluded_members            = each.value.excluded_members
  static_members              = each.value.static_members
  tags                        = merge(var.tags, each.value.tags)

  depends_on = [
    aws_rds_cluster_instance.this
  ]
}

################################################################################
# Cluster IAM Roles
################################################################################

resource "aws_rds_cluster_role_association" "this" {
  for_each = { for k, v in var.role_associations : k => v if local.create }

  region = var.region

  db_cluster_identifier = aws_rds_cluster.this[0].id
  feature_name          = try(coalesce(each.value.feature_name, each.key))
  role_arn              = each.value.role_arn
}

################################################################################
# Enhanced Monitoring
################################################################################

locals {
  instances_has_monitoring_enabled = anytrue([for k, v in var.instances : v.monitoring_interval != null && try(coalesce(v.monitoring_interval, 0), 0) > 0])
  create_monitoring_role           = local.create && var.create_monitoring_role && (local.instances_has_monitoring_enabled || var.cluster_monitoring_interval > 0)

  iam_role_name = try(coalesce(var.iam_role_name, "${var.name}-monitor"))
}

data "aws_service_principal" "monitoring_rds" {
  count = local.create_monitoring_role ? 1 : 0

  service_name = "monitoring.rds"
}

data "aws_iam_policy_document" "monitoring_rds_assume_role" {
  count = local.create_monitoring_role ? 1 : 0

  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = [data.aws_service_principal.monitoring_rds[0].name]
    }
  }
}

resource "aws_iam_role" "rds_enhanced_monitoring" {
  count = local.create_monitoring_role ? 1 : 0

  name        = var.iam_role_use_name_prefix ? null : local.iam_role_name
  name_prefix = var.iam_role_use_name_prefix ? "${local.iam_role_name}-" : null
  description = var.iam_role_description
  path        = var.iam_role_path

  assume_role_policy    = data.aws_iam_policy_document.monitoring_rds_assume_role[0].json
  permissions_boundary  = var.iam_role_permissions_boundary
  force_detach_policies = true
  max_session_duration  = var.iam_role_max_session_duration

  tags = var.tags
}

resource "aws_iam_role_policy_attachment" "rds_enhanced_monitoring" {
  count = local.create_monitoring_role ? 1 : 0

  role       = aws_iam_role.rds_enhanced_monitoring[0].name
  policy_arn = "arn:${data.aws_partition.current.partition}:iam::aws:policy/service-role/AmazonRDSEnhancedMonitoringRole"
}

################################################################################
# Autoscaling
################################################################################

resource "aws_appautoscaling_target" "this" {
  count = local.create && var.autoscaling_enabled && !local.is_serverless ? 1 : 0

  region = var.region

  max_capacity       = var.autoscaling_max_capacity
  min_capacity       = var.autoscaling_min_capacity
  resource_id        = "cluster:${aws_rds_cluster.this[0].cluster_identifier}"
  scalable_dimension = "rds:cluster:ReadReplicaCount"
  service_namespace  = "rds"

  tags = var.tags

  lifecycle {
    ignore_changes = [
      tags_all,
    ]
  }
}

resource "aws_appautoscaling_policy" "this" {
  count = local.create && var.autoscaling_enabled && !local.is_serverless ? 1 : 0

  region = var.region

  name               = var.autoscaling_policy_name
  policy_type        = "TargetTrackingScaling"
  resource_id        = "cluster:${aws_rds_cluster.this[0].cluster_identifier}"
  scalable_dimension = "rds:cluster:ReadReplicaCount"
  service_namespace  = "rds"

  target_tracking_scaling_policy_configuration {
    predefined_metric_specification {
      predefined_metric_type = var.predefined_metric_type
    }

    scale_in_cooldown  = var.autoscaling_scale_in_cooldown
    scale_out_cooldown = var.autoscaling_scale_out_cooldown
    target_value       = var.predefined_metric_type == "RDSReaderAverageCPUUtilization" ? var.autoscaling_target_cpu : var.autoscaling_target_connections
  }

  depends_on = [
    aws_appautoscaling_target.this
  ]
}

################################################################################
# Security Group
################################################################################

locals {
  create_security_group = local.create && var.create_security_group
  security_group_name   = try(coalesce(var.security_group_name, var.name), "")
}

resource "aws_security_group" "this" {
  count = local.create_security_group ? 1 : 0

  region = var.region

  name        = var.security_group_use_name_prefix ? null : local.security_group_name
  name_prefix = var.security_group_use_name_prefix ? "${local.security_group_name}-" : null
  vpc_id      = var.vpc_id
  description = coalesce(var.security_group_description, "Control traffic to/from RDS Aurora ${local.create_security_group}")

  tags = merge(
    var.tags,
    var.security_group_tags,
    { "Name" = local.security_group_name }
  )

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_vpc_security_group_ingress_rule" "this" {
  for_each = { for k, v in var.security_group_ingress_rules : k => v if var.security_group_ingress_rules != null && local.create_security_group }

  region = var.region

  cidr_ipv4                    = each.value.cidr_ipv4
  cidr_ipv6                    = each.value.cidr_ipv6
  description                  = each.value.description
  from_port                    = try(coalesce(each.value.from_port, local.port), null)
  ip_protocol                  = each.value.ip_protocol
  prefix_list_id               = each.value.prefix_list_id
  referenced_security_group_id = each.value.referenced_security_group_id == "self" ? aws_security_group.this[0].id : each.value.referenced_security_group_id
  security_group_id            = aws_security_group.this[0].id
  tags = merge(
    var.tags,
    { "Name" = coalesce(each.value.name, "${local.security_group_name}-${each.key}") },
    each.value.tags
  )
  to_port = try(coalesce(each.value.to_port, each.value.from_port, local.port), null)
}

resource "aws_vpc_security_group_egress_rule" "this" {
  for_each = { for k, v in var.security_group_egress_rules : k => v if var.security_group_egress_rules != null && local.create_security_group }

  region = var.region

  cidr_ipv4                    = each.value.cidr_ipv4
  cidr_ipv6                    = each.value.cidr_ipv6
  description                  = each.value.description
  from_port                    = try(coalesce(each.value.from_port, each.value.to_port, local.port), null)
  ip_protocol                  = each.value.ip_protocol
  prefix_list_id               = each.value.prefix_list_id
  referenced_security_group_id = each.value.referenced_security_group_id == "self" ? aws_security_group.this[0].id : each.value.referenced_security_group_id
  security_group_id            = aws_security_group.this[0].id
  tags = merge(
    var.tags,
    { "Name" = coalesce(each.value.name, "${local.security_group_name}-${each.key}") },
    each.value.tags
  )
  to_port = try(coalesce(each.value.to_port, local.port), null)
}


################################################################################
# Cluster Parameter Group
################################################################################

locals {
  create_cluster_parameter_group = local.create && var.cluster_parameter_group != null
}

resource "aws_rds_cluster_parameter_group" "this" {
  count = local.create_cluster_parameter_group ? 1 : 0

  region = var.region

  name        = var.cluster_parameter_group.use_name_prefix ? null : try(coalesce(var.cluster_parameter_group.name, var.name), "")
  name_prefix = var.cluster_parameter_group.use_name_prefix ? "${try(coalesce(var.cluster_parameter_group.name, var.name), "")}-" : null
  description = coalesce(var.cluster_parameter_group.description, "${var.cluster_parameter_group.family} for Aurora cluster ${var.name}")
  family      = var.cluster_parameter_group.family

  dynamic "parameter" {
    for_each = var.cluster_parameter_group.parameters != null ? var.cluster_parameter_group.parameters : []

    content {
      name         = try(coalesce(parameter.value.name, parameter.key))
      value        = parameter.value.value
      apply_method = parameter.value.apply_method
    }
  }

  lifecycle {
    create_before_destroy = true
  }

  tags = var.tags
}

################################################################################
# DB Parameter Group
################################################################################

locals {
  create_db_parameter_group = local.create && var.db_parameter_group != null
}

resource "aws_db_parameter_group" "this" {
  count = local.create_db_parameter_group ? 1 : 0

  region = var.region

  name        = var.db_parameter_group.use_name_prefix ? null : try(coalesce(var.db_parameter_group.name, var.name), "")
  name_prefix = var.db_parameter_group.use_name_prefix ? "${try(coalesce(var.db_parameter_group.name, var.name), "")}-" : null
  description = coalesce(var.db_parameter_group.description, "${var.db_parameter_group.family} for Aurora cluster ${var.name}")
  family      = var.db_parameter_group.family

  dynamic "parameter" {
    for_each = var.db_parameter_group.parameters != null ? var.db_parameter_group.parameters : []

    content {
      name         = try(coalesce(parameter.value.name, parameter.key))
      value        = parameter.value.value
      apply_method = parameter.value.apply_method
    }
  }

  lifecycle {
    create_before_destroy = true
  }

  tags = var.tags
}

################################################################################
# CloudWatch Log Group
################################################################################

# Log groups will not be created if using a cluster identifier prefix
resource "aws_cloudwatch_log_group" "this" {
  for_each = toset([for log in var.enabled_cloudwatch_logs_exports : log if local.create && var.create_cloudwatch_log_group && !var.cluster_use_name_prefix])

  region = var.region

  name              = "/aws/rds/cluster/${var.name}/${each.value}"
  retention_in_days = var.cloudwatch_log_group_retention_in_days
  kms_key_id        = var.cloudwatch_log_group_kms_key_id
  skip_destroy      = var.cloudwatch_log_group_skip_destroy
  log_group_class   = var.cloudwatch_log_group_class

  tags = merge(var.tags, var.cloudwatch_log_group_tags)
}

################################################################################
# Cluster Activity Stream
################################################################################

resource "aws_rds_cluster_activity_stream" "this" {
  count = local.create && var.cluster_activity_stream != null ? 1 : 0

  region = var.region

  engine_native_audit_fields_included = var.cluster_activity_stream.include_audit_fields
  kms_key_id                          = var.cluster_activity_stream.kms_key_id
  mode                                = var.cluster_activity_stream.mode
  resource_arn                        = aws_rds_cluster.this[0].arn

  depends_on = [aws_rds_cluster_instance.this]
}

################################################################################
# Managed Secret Rotation
################################################################################

# There is not currently a way to disable secret rotation on an initial apply.
# In order to use master password secrets management without a rotation, the following workaround can be used:
# `manage_master_user_password_rotation` must be set to true first and applied followed by setting it to false and another apply.
# Note: when setting `manage_master_user_password_rotation` to true, a schedule must also be set using `master_user_password_rotation_schedule_expression` or `master_user_password_rotation_automatically_after_days`.
# To prevent password from being immediately rotated when implementing this workaround, set `master_user_password_rotate_immediately` to false.
# See: https://github.com/hashicorp/terraform-provider-aws/issues/37779
resource "aws_secretsmanager_secret_rotation" "this" {
  count = local.create && var.manage_master_user_password && var.manage_master_user_password_rotation ? 1 : 0

  region = var.region

  secret_id          = aws_rds_cluster.this[0].master_user_secret[0].secret_arn
  rotate_immediately = var.master_user_password_rotate_immediately

  rotation_rules {
    automatically_after_days = var.master_user_password_rotation_automatically_after_days
    duration                 = var.master_user_password_rotation_duration
    schedule_expression      = var.master_user_password_rotation_schedule_expression
  }
}

################################################################################
# RDS Shard Group
################################################################################

resource "aws_rds_shard_group" "this" {
  count = local.create && var.shard_group != null ? 1 : 0

  region = var.region

  compute_redundancy        = var.shard_group.compute_redundancy
  db_cluster_identifier     = aws_rds_cluster.this[0].id
  db_shard_group_identifier = var.shard_group.identifier
  max_acu                   = var.shard_group.max_acu
  min_acu                   = var.shard_group.min_acu
  publicly_accessible       = var.shard_group.publicly_accessible
  tags                      = merge(var.tags, var.shard_group.tags)

  dynamic "timeouts" {
    for_each = var.shard_group.timeouts != null ? [var.shard_group.timeouts] : []

    content {
      create = timeouts.value.create
      update = timeouts.value.update
      delete = timeouts.value.delete
    }
  }
}
