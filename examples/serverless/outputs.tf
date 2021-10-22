################################################################################
# RDS Aurora Module - PostgreSQL
################################################################################

# aws_rds_cluster
output "postgresql_rds_cluster_id" {
  description = "The ID of the cluster"
  value       = module.aurora_postgresql.rds_cluster_id
}

output "postgresql_rds_cluster_resource_id" {
  description = "The Resource ID of the cluster"
  value       = module.aurora_postgresql.rds_cluster_resource_id
}

output "postgresql_rds_cluster_endpoint" {
  description = "The cluster endpoint"
  value       = module.aurora_postgresql.rds_cluster_endpoint
}

output "postgresql_rds_cluster_reader_endpoint" {
  description = "The cluster reader endpoint"
  value       = module.aurora_postgresql.rds_cluster_reader_endpoint
}

output "postgresql_rds_cluster_database_name" {
  description = "Name for an automatically created database on cluster creation"
  value       = module.aurora_postgresql.rds_cluster_database_name
}

output "postgresql_rds_cluster_master_password" {
  description = "The master password"
  value       = module.aurora_postgresql.rds_cluster_master_password
  sensitive   = true
}

output "postgresql_rds_cluster_port" {
  description = "The port"
  value       = module.aurora_postgresql.rds_cluster_port
}

output "postgresql_rds_cluster_master_username" {
  description = "The master username"
  value       = module.aurora_postgresql.rds_cluster_master_username
  sensitive   = true
}

# aws_rds_cluster_instances
output "postgresql_rds_cluster_instances" {
  description = "A map of cluster instances and their attributes"
  value       = module.aurora_postgresql.rds_cluster_instances
}

# aws_security_group
output "security_group_id" {
  description = "The security group ID of the cluster"
  value       = module.aurora_postgresql.security_group_id
}

# Enhanced monitoring role
output "enhanced_monitoring_iam_role_name" {
  description = "The name of the enhanced monitoring role"
  value       = module.aurora_postgresql.enhanced_monitoring_iam_role_name
}

output "enhanced_monitoring_iam_role_arn" {
  description = "The Amazon Resource Name (ARN) specifying the enhanced monitoring role"
  value       = module.aurora_postgresql.enhanced_monitoring_iam_role_arn
}

output "enhanced_monitoring_iam_role_unique_id" {
  description = "Stable and unique string identifying the enhanced monitoring role"
  value       = module.aurora_postgresql.enhanced_monitoring_iam_role_unique_id
}

################################################################################
# RDS Aurora Module - MySQL
################################################################################

# aws_rds_cluster
output "mysql_rds_cluster_id" {
  description = "The ID of the cluster"
  value       = module.aurora_mysql.rds_cluster_id
}

output "mysql_rds_cluster_resource_id" {
  description = "The Resource ID of the cluster"
  value       = module.aurora_mysql.rds_cluster_resource_id
}

output "mysql_rds_cluster_endpoint" {
  description = "The cluster endpoint"
  value       = module.aurora_mysql.rds_cluster_endpoint
}

output "mysql_rds_cluster_reader_endpoint" {
  description = "The cluster reader endpoint"
  value       = module.aurora_mysql.rds_cluster_reader_endpoint
}

output "mysql_rds_cluster_database_name" {
  description = "Name for an automatically created database on cluster creation"
  value       = module.aurora_mysql.rds_cluster_database_name
}

output "mysql_rds_cluster_master_password" {
  description = "The master password"
  value       = module.aurora_mysql.rds_cluster_master_password
  sensitive   = true
}

output "mysql_rds_cluster_port" {
  description = "The port"
  value       = module.aurora_mysql.rds_cluster_port
}

output "mysql_rds_cluster_master_username" {
  description = "The master username"
  value       = module.aurora_mysql.rds_cluster_master_username
  sensitive   = true
}

# aws_rds_cluster_instances
output "mysql_rds_cluster_instances" {
  description = "A map of cluster instances and their attributes"
  value       = module.aurora_mysql.rds_cluster_instances
}

# aws_security_group
output "mysql_security_group_id" {
  description = "The security group ID of the cluster"
  value       = module.aurora_mysql.security_group_id
}

# Enhanced monitoring role
output "mysql_enhanced_monitoring_iam_role_name" {
  description = "The name of the enhanced monitoring role"
  value       = module.aurora_mysql.enhanced_monitoring_iam_role_name
}

output "mysql_enhanced_monitoring_iam_role_arn" {
  description = "The Amazon Resource Name (ARN) specifying the enhanced monitoring role"
  value       = module.aurora_mysql.enhanced_monitoring_iam_role_arn
}

output "mysql_enhanced_monitoring_iam_role_unique_id" {
  description = "Stable and unique string identifying the enhanced monitoring role"
  value       = module.aurora_mysql.enhanced_monitoring_iam_role_unique_id
}
