################################################################################
# Cluster
################################################################################

output "cluster_arn" {
  description = "Amazon Resource Name (ARN) of cluster"
  value       = module.aurora.cluster_arn
}

output "cluster_id" {
  description = "The RDS Cluster Identifier"
  value       = module.aurora.cluster_id
}

output "cluster_endpoint" {
  description = "Writer endpoint for the cluster"
  value       = module.aurora.cluster_endpoint
}

output "cluster_reader_endpoint" {
  description = "A read-only endpoint for the cluster, automatically load-balanced across replicas"
  value       = module.aurora.cluster_reader_endpoint
}

output "cluster_master_user_secret" {
  description = "The generated database master user secret when `manage_master_user_password` is set to `true`"
  value       = module.aurora.cluster_master_user_secret
}

################################################################################
# Cluster Instance(s)
################################################################################

output "cluster_instances" {
  description = "A map of cluster instances and their attributes"
  value       = module.aurora.cluster_instances
}

################################################################################
# CloudWatch Log Group
################################################################################

output "db_cluster_cloudwatch_log_groups" {
  description = "Map of CloudWatch log groups created and their attributes"
  value       = module.aurora.db_cluster_cloudwatch_log_groups
}

################################################################################
# Cluster Activity Stream
################################################################################

output "db_cluster_activity_stream_kinesis_stream_name" {
  description = "The name of the Amazon Kinesis data stream to be used for the database activity stream"
  value       = module.aurora.db_cluster_activity_stream_kinesis_stream_name
}

################################################################################
# Security Group
################################################################################

output "security_group_id" {
  description = "The security group ID of the cluster"
  value       = module.aurora.security_group_id
}

################################################################################
# KMS Key
################################################################################

output "kms_key_arn" {
  description = "ARN of the KMS key protecting the cluster, logs, Performance Insights, and activity stream"
  value       = local.kms_key_arn
}
