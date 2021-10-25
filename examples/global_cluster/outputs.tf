################################################################################
# RDS Aurora Module - Primary
################################################################################

# aws_db_subnet_group
output "primary_db_subnet_group_name" {
  description = "The db subnet group name"
  value       = module.aurora_primary.db_subnet_group_name
}

# aws_rds_cluster
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

# database_name is not set on `aws_rds_cluster` resource if it was not specified, so can't be used in output
output "primary_cluster_database_name" {
  description = "Name for an automatically created database on cluster creation"
  value       = module.aurora_primary.cluster_database_name
}

output "primary_cluster_port" {
  description = "The database port"
  value       = module.aurora_primary.cluster_port
}

output "primary_cluster_master_password" {
  description = "The database master password"
  value       = module.aurora_primary.cluster_master_password
  sensitive   = true
}

output "primary_cluster_master_username" {
  description = "The database master username"
  value       = module.aurora_primary.cluster_master_username
  sensitive   = true
}

output "primary_cluster_hosted_zone_id" {
  description = "The Route53 Hosted Zone ID of the endpoint"
  value       = module.aurora_primary.cluster_hosted_zone_id
}

# aws_rds_cluster_instances
output "primary_cluster_instances" {
  description = "A map of cluster instances and their attributes"
  value       = module.aurora_primary.cluster_instances
}

# aws_rds_cluster_endpoint
output "primary_additional_cluster_endpoints" {
  description = "A map of additional cluster endpoints and their attributes"
  value       = module.aurora_primary.additional_cluster_endpoints
}

# aws_rds_cluster_role_association
output "primary_cluster_role_associations" {
  description = "A map of IAM roles associated with the cluster and their attributes"
  value       = module.aurora_primary.cluster_role_associations
}

# Enhanced monitoring role
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

# aws_security_group
output "primary_security_group_id" {
  description = "The security group ID of the cluster"
  value       = module.aurora_primary.security_group_id
}

################################################################################
# RDS Aurora Module - Secondary
################################################################################

# aws_db_subnet_group
output "mysql_db_subnet_group_name" {
  description = "The db subnet group name"
  value       = module.aurora_secondary.db_subnet_group_name
}

# aws_rds_cluster
output "mysql_cluster_arn" {
  description = "Amazon Resource Name (ARN) of cluster"
  value       = module.aurora_secondary.cluster_arn
}

output "mysql_cluster_id" {
  description = "The RDS Cluster Identifier"
  value       = module.aurora_secondary.cluster_id
}

output "mysql_cluster_resource_id" {
  description = "The RDS Cluster Resource ID"
  value       = module.aurora_secondary.cluster_resource_id
}

output "mysql_cluster_members" {
  description = "List of RDS Instances that are a part of this cluster"
  value       = module.aurora_secondary.cluster_members
}

output "mysql_cluster_endpoint" {
  description = "Writer endpoint for the cluster"
  value       = module.aurora_secondary.cluster_endpoint
}

output "mysql_cluster_reader_endpoint" {
  description = "A read-only endpoint for the cluster, automatically load-balanced across replicas"
  value       = module.aurora_secondary.cluster_reader_endpoint
}

output "mysql_cluster_engine_version_actual" {
  description = "The running version of the cluster database"
  value       = module.aurora_secondary.cluster_engine_version_actual
}

# database_name is not set on `aws_rds_cluster` resource if it was not specified, so can't be used in output
output "mysql_cluster_database_name" {
  description = "Name for an automatically created database on cluster creation"
  value       = module.aurora_secondary.cluster_database_name
}

output "mysql_cluster_port" {
  description = "The database port"
  value       = module.aurora_secondary.cluster_port
}

output "mysql_cluster_master_password" {
  description = "The database master password"
  value       = module.aurora_secondary.cluster_master_password
  sensitive   = true
}

output "mysql_cluster_master_username" {
  description = "The database master username"
  value       = module.aurora_secondary.cluster_master_username
  sensitive   = true
}

output "mysql_cluster_hosted_zone_id" {
  description = "The Route53 Hosted Zone ID of the endpoint"
  value       = module.aurora_secondary.cluster_hosted_zone_id
}

# aws_rds_cluster_instances
output "mysql_cluster_instances" {
  description = "A map of cluster instances and their attributes"
  value       = module.aurora_secondary.cluster_instances
}

# aws_rds_cluster_endpoint
output "mysql_additional_cluster_endpoints" {
  description = "A map of additional cluster endpoints and their attributes"
  value       = module.aurora_secondary.additional_cluster_endpoints
}

# aws_rds_cluster_role_association
output "mysql_cluster_role_associations" {
  description = "A map of IAM roles associated with the cluster and their attributes"
  value       = module.aurora_secondary.cluster_role_associations
}

# Enhanced monitoring role
output "mysql_enhanced_monitoring_iam_role_name" {
  description = "The name of the enhanced monitoring role"
  value       = module.aurora_secondary.enhanced_monitoring_iam_role_name
}

output "mysql_enhanced_monitoring_iam_role_arn" {
  description = "The Amazon Resource Name (ARN) specifying the enhanced monitoring role"
  value       = module.aurora_secondary.enhanced_monitoring_iam_role_arn
}

output "mysql_enhanced_monitoring_iam_role_unique_id" {
  description = "Stable and unique string identifying the enhanced monitoring role"
  value       = module.aurora_secondary.enhanced_monitoring_iam_role_unique_id
}

# aws_security_group
output "mysql_security_group_id" {
  description = "The security group ID of the cluster"
  value       = module.aurora_secondary.security_group_id
}
