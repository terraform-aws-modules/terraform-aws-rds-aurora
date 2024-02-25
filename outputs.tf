################################################################################
# DB Subnet Group
################################################################################

output "db_subnet_group_name" {
  description = "The db subnet group name"
  value       = local.db_subnet_group_name
}

################################################################################
# Cluster
################################################################################

output "cluster_arn" {
  description = "Amazon Resource Name (ARN) of cluster"
  value       = try(aws_rds_cluster.this[0].arn, null)
}

output "cluster_id" {
  description = "The RDS Cluster Identifier"
  value       = try(aws_rds_cluster.this[0].id, null)
}

output "cluster_resource_id" {
  description = "The RDS Cluster Resource ID"
  value       = try(aws_rds_cluster.this[0].cluster_resource_id, null)
}

output "cluster_members" {
  description = "List of RDS Instances that are a part of this cluster"
  value       = try(aws_rds_cluster.this[0].cluster_members, null)
}

output "cluster_endpoint" {
  description = "Writer endpoint for the cluster"
  value       = try(aws_rds_cluster.this[0].endpoint, null)
}

output "cluster_reader_endpoint" {
  description = "A read-only endpoint for the cluster, automatically load-balanced across replicas"
  value       = try(aws_rds_cluster.this[0].reader_endpoint, null)
}

output "cluster_engine_version_actual" {
  description = "The running version of the cluster database"
  value       = try(aws_rds_cluster.this[0].engine_version_actual, null)
}

# database_name is not set on `aws_rds_cluster` resource if it was not specified, so can't be used in output
output "cluster_database_name" {
  description = "Name for an automatically created database on cluster creation"
  value       = var.database_name
}

output "cluster_port" {
  description = "The database port"
  value       = try(aws_rds_cluster.this[0].port, null)
}

output "cluster_master_password" {
  description = "The database master password"
  value       = try(aws_rds_cluster.this[0].master_password, null)
  sensitive   = true
}

output "cluster_master_username" {
  description = "The database master username"
  value       = try(aws_rds_cluster.this[0].master_username, null)
  sensitive   = true
}

output "cluster_master_user_secret" {
  description = "The generated database master user secret when `manage_master_user_password` is set to `true`"
  value       = try(aws_rds_cluster.this[0].master_user_secret, null)
}

output "cluster_hosted_zone_id" {
  description = "The Route53 Hosted Zone ID of the endpoint"
  value       = try(aws_rds_cluster.this[0].hosted_zone_id, null)
}

################################################################################
# Cluster Instance(s)
################################################################################

output "cluster_instances" {
  description = "A map of cluster instances and their attributes"
  value       = aws_rds_cluster_instance.this
}

################################################################################
# Cluster Endpoint(s)
################################################################################

output "additional_cluster_endpoints" {
  description = "A map of additional cluster endpoints and their attributes"
  value       = aws_rds_cluster_endpoint.this
}

################################################################################
# Cluster IAM Roles
################################################################################

output "cluster_role_associations" {
  description = "A map of IAM roles associated with the cluster and their attributes"
  value       = aws_rds_cluster_role_association.this
}

################################################################################
# Enhanced Monitoring
################################################################################

output "enhanced_monitoring_iam_role_name" {
  description = "The name of the enhanced monitoring role"
  value       = try(aws_iam_role.rds_enhanced_monitoring[0].name, null)
}

output "enhanced_monitoring_iam_role_arn" {
  description = "The Amazon Resource Name (ARN) specifying the enhanced monitoring role"
  value       = try(aws_iam_role.rds_enhanced_monitoring[0].arn, null)
}

output "enhanced_monitoring_iam_role_unique_id" {
  description = "Stable and unique string identifying the enhanced monitoring role"
  value       = try(aws_iam_role.rds_enhanced_monitoring[0].unique_id, null)
}

################################################################################
# Security Group
################################################################################

output "security_group_id" {
  description = "The security group ID of the cluster"
  value       = try(aws_security_group.this[0].id, null)
}

################################################################################
# Cluster Parameter Group
################################################################################

output "db_cluster_parameter_group_arn" {
  description = "The ARN of the DB cluster parameter group created"
  value       = try(aws_rds_cluster_parameter_group.this[0].arn, null)
}

output "db_cluster_parameter_group_id" {
  description = "The ID of the DB cluster parameter group created"
  value       = try(aws_rds_cluster_parameter_group.this[0].id, null)
}

################################################################################
# DB Parameter Group
################################################################################

output "db_parameter_group_arn" {
  description = "The ARN of the DB parameter group created"
  value       = try(aws_db_parameter_group.this[0].arn, null)
}

output "db_parameter_group_id" {
  description = "The ID of the DB parameter group created"
  value       = try(aws_db_parameter_group.this[0].id, null)
}

################################################################################
# CloudWatch Log Group
################################################################################

output "db_cluster_cloudwatch_log_groups" {
  description = "Map of CloudWatch log groups created and their attributes"
  value       = aws_cloudwatch_log_group.this
}

################################################################################
# Cluster Activity Stream
################################################################################

output "db_cluster_activity_stream_kinesis_stream_name" {
  description = "The name of the Amazon Kinesis data stream to be used for the database activity stream"
  value       = try(aws_rds_cluster_activity_stream.this[0].kinesis_stream_name, null)
}

################################################################################
# Managed Secret Rotation
################################################################################

output "db_cluster_secretsmanager_secret_rotation_enabled" {
  description = "Specifies whether automatic rotation is enabled for the secret"
  value       = try(aws_secretsmanager_secret_rotation.this[0].rotation_enabled, null)
}
