################################################################################
# RDS Aurora Module - Primary
################################################################################

output "primary_db_subnet_group_name" {
  description = "The db subnet group name"
  value       = module.aurora_primary.db_subnet_group_name
}

output "primary_cluster_arn" {
  description = "Amazon Resource Name (ARN) of cluster"
  value       = module.aurora_primary.cluster_arn
}

output "primary_cluster_id" {
  description = "The RDS Cluster Identifier"
  value       = module.aurora_primary.cluster_id
}

output "primary_cluster_resource_id" {
  description = "The RDS Cluster Resource ID"
  value       = module.aurora_primary.cluster_resource_id
}

output "primary_cluster_members" {
  description = "List of RDS Instances that are a part of this cluster"
  value       = module.aurora_primary.cluster_members
}

output "primary_cluster_endpoint" {
  description = "Writer endpoint for the cluster"
  value       = module.aurora_primary.cluster_endpoint
}

output "primary_cluster_reader_endpoint" {
  description = "A read-only endpoint for the cluster, automatically load-balanced across replicas"
  value       = module.aurora_primary.cluster_reader_endpoint
}

output "primary_cluster_engine_version_actual" {
  description = "The running version of the cluster database"
  value       = module.aurora_primary.cluster_engine_version_actual
}

output "primary_cluster_database_name" {
  description = "Name for an automatically created database on cluster creation"
  value       = module.aurora_primary.cluster_database_name
}

output "primary_cluster_port" {
  description = "The database port"
  value       = module.aurora_primary.cluster_port
}

output "primary_cluster_master_user_secret" {
  description = "The generated database master user secret when `manage_master_user_password` is set to `true`"
  value       = module.aurora_primary.cluster_master_user_secret
}

output "primary_cluster_hosted_zone_id" {
  description = "The Route53 Hosted Zone ID of the endpoint"
  value       = module.aurora_primary.cluster_hosted_zone_id
}

output "primary_cluster_instances" {
  description = "A map of cluster instances and their attributes"
  value       = module.aurora_primary.cluster_instances
}

output "primary_additional_cluster_endpoints" {
  description = "A map of additional cluster endpoints and their attributes"
  value       = module.aurora_primary.additional_cluster_endpoints
}

output "primary_cluster_role_associations" {
  description = "A map of IAM roles associated with the cluster and their attributes"
  value       = module.aurora_primary.cluster_role_associations
}

output "primary_enhanced_monitoring_iam_role_name" {
  description = "The name of the enhanced monitoring role"
  value       = module.aurora_primary.enhanced_monitoring_iam_role_name
}

output "primary_enhanced_monitoring_iam_role_arn" {
  description = "The Amazon Resource Name (ARN) specifying the enhanced monitoring role"
  value       = module.aurora_primary.enhanced_monitoring_iam_role_arn
}

output "primary_enhanced_monitoring_iam_role_unique_id" {
  description = "Stable and unique string identifying the enhanced monitoring role"
  value       = module.aurora_primary.enhanced_monitoring_iam_role_unique_id
}

output "primary_security_group_id" {
  description = "The security group ID of the cluster"
  value       = module.aurora_primary.security_group_id
}

output "primary_db_cluster_parameter_group_arn" {
  description = "The ARN of the DB cluster parameter group created"
  value       = module.aurora_primary.db_cluster_parameter_group_arn
}

output "primary_db_cluster_parameter_group_id" {
  description = "The ID of the DB cluster parameter group created"
  value       = module.aurora_primary.db_cluster_parameter_group_id
}

output "primary_db_parameter_group_arn" {
  description = "The ARN of the DB parameter group created"
  value       = module.aurora_primary.db_parameter_group_arn
}

output "primary_db_parameter_group_id" {
  description = "The ID of the DB parameter group created"
  value       = module.aurora_primary.db_parameter_group_id
}

output "primary_db_cluster_cloudwatch_log_groups" {
  description = "Map of CloudWatch log groups created and their attributes"
  value       = module.aurora_primary.db_cluster_cloudwatch_log_groups
}

################################################################################
# RDS Aurora Module - Secondary
################################################################################

output "secondary_db_subnet_group_name" {
  description = "The db subnet group name"
  value       = module.aurora_secondary.db_subnet_group_name
}

output "secondary_cluster_arn" {
  description = "Amazon Resource Name (ARN) of cluster"
  value       = module.aurora_secondary.cluster_arn
}

output "secondary_cluster_id" {
  description = "The RDS Cluster Identifier"
  value       = module.aurora_secondary.cluster_id
}

output "secondary_cluster_resource_id" {
  description = "The RDS Cluster Resource ID"
  value       = module.aurora_secondary.cluster_resource_id
}

output "secondary_cluster_members" {
  description = "List of RDS Instances that are a part of this cluster"
  value       = module.aurora_secondary.cluster_members
}

output "secondary_cluster_endpoint" {
  description = "Writer endpoint for the cluster"
  value       = module.aurora_secondary.cluster_endpoint
}

output "secondary_cluster_reader_endpoint" {
  description = "A read-only endpoint for the cluster, automatically load-balanced across replicas"
  value       = module.aurora_secondary.cluster_reader_endpoint
}

output "secondary_cluster_engine_version_actual" {
  description = "The running version of the cluster database"
  value       = module.aurora_secondary.cluster_engine_version_actual
}

output "secondary_cluster_database_name" {
  description = "Name for an automatically created database on cluster creation"
  value       = module.aurora_secondary.cluster_database_name
}

output "secondary_cluster_port" {
  description = "The database port"
  value       = module.aurora_secondary.cluster_port
}

output "secondary_cluster_master_user_secret" {
  description = "The generated database master user secret when `manage_master_user_password` is set to `true`"
  value       = module.aurora_secondary.cluster_master_user_secret
}

output "secondary_cluster_hosted_zone_id" {
  description = "The Route53 Hosted Zone ID of the endpoint"
  value       = module.aurora_secondary.cluster_hosted_zone_id
}

output "secondary_cluster_instances" {
  description = "A map of cluster instances and their attributes"
  value       = module.aurora_secondary.cluster_instances
}

output "secondary_additional_cluster_endpoints" {
  description = "A map of additional cluster endpoints and their attributes"
  value       = module.aurora_secondary.additional_cluster_endpoints
}

output "secondary_cluster_role_associations" {
  description = "A map of IAM roles associated with the cluster and their attributes"
  value       = module.aurora_secondary.cluster_role_associations
}

output "secondary_enhanced_monitoring_iam_role_name" {
  description = "The name of the enhanced monitoring role"
  value       = module.aurora_secondary.enhanced_monitoring_iam_role_name
}

output "secondary_enhanced_monitoring_iam_role_arn" {
  description = "The Amazon Resource Name (ARN) specifying the enhanced monitoring role"
  value       = module.aurora_secondary.enhanced_monitoring_iam_role_arn
}

output "secondary_enhanced_monitoring_iam_role_unique_id" {
  description = "Stable and unique string identifying the enhanced monitoring role"
  value       = module.aurora_secondary.enhanced_monitoring_iam_role_unique_id
}

output "secondary_security_group_id" {
  description = "The security group ID of the cluster"
  value       = module.aurora_secondary.security_group_id
}

output "secondary_db_cluster_parameter_group_arn" {
  description = "The ARN of the DB cluster parameter group created"
  value       = module.aurora_secondary.db_cluster_parameter_group_arn
}

output "secondary_db_cluster_parameter_group_id" {
  description = "The ID of the DB cluster parameter group created"
  value       = module.aurora_secondary.db_cluster_parameter_group_id
}

output "secondary_db_parameter_group_arn" {
  description = "The ARN of the DB parameter group created"
  value       = module.aurora_secondary.db_parameter_group_arn
}

output "secondary_db_parameter_group_id" {
  description = "The ID of the DB parameter group created"
  value       = module.aurora_secondary.db_parameter_group_id
}

output "secondary_db_cluster_cloudwatch_log_groups" {
  description = "Map of CloudWatch log groups created and their attributes"
  value       = module.aurora_secondary.db_cluster_cloudwatch_log_groups
}
