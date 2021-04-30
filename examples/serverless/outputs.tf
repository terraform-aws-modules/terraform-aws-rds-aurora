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

# aws_rds_cluster_instance
output "postgresql_rds_cluster_instance_endpoints" {
  description = "A list of all cluster instance endpoints"
  value       = module.aurora_postgresql.rds_cluster_instance_endpoints
}

output "postgresql_rds_cluster_instance_ids" {
  description = "A list of all cluster instance ids"
  value       = module.aurora_postgresql.rds_cluster_instance_ids
}

# aws_security_group
output "postgresql_security_group_id" {
  description = "The security group ID of the cluster"
  value       = module.aurora_postgresql.security_group_id
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
}

# aws_rds_cluster_instance
output "mysql_rds_cluster_instance_endpoints" {
  description = "A list of all cluster instance endpoints"
  value       = module.aurora_mysql.rds_cluster_instance_endpoints
}

output "mysql_rds_cluster_instance_ids" {
  description = "A list of all cluster instance ids"
  value       = module.aurora_mysql.rds_cluster_instance_ids
}

# aws_security_group
output "mysql_security_group_id" {
  description = "The security group ID of the cluster"
  value       = module.aurora_mysql.security_group_id
}
