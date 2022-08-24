# aws_db_subnet_group
output "db_subnet_group_name" {
  description = "The db subnet group name"
  value       = module.rds_cluster.db_subnet_group_name
}

# aws_rds_cluster
output "cluster_arn" {
  description = "Amazon Resource Name (ARN) of cluster"
  value       = module.rds_cluster.cluster_arn
}

output "cluster_id" {
  description = "The RDS Cluster Identifier"
  value       = module.rds_cluster.cluster_id
}

output "cluster_resource_id" {
  description = "The RDS Cluster Resource ID"
  value       = module.rds_cluster.cluster_resource_id
}

output "cluster_endpoint" {
  description = "Writer endpoint for the cluster"
  value       = module.rds_cluster.cluster_endpoint
}

output "cluster_reader_endpoint" {
  description = "A read-only endpoint for the cluster, automatically load-balanced across replicas"
  value       = module.rds_cluster.cluster_reader_endpoint
}

output "cluster_engine_version_actual" {
  description = "The running version of the cluster database"
  value       = module.rds_cluster.cluster_engine_version_actual
}

# database_name is not set on `aws_rds_cluster` resource if it was not specified, so can't be used in output
output "cluster_database_name" {
  description = "Name for an automatically created database on cluster creation"
  value       = module.rds_cluster.cluster_database_name
}

output "cluster_port" {
  description = "The database port"
  value       = module.rds_cluster.cluster_port
}

output "cluster_master_password" {
  description = "The database master password"
  value       = module.rds_cluster.cluster_master_password
  sensitive   = true
}

output "cluster_master_username" {
  description = "The database master username"
  value       = module.rds_cluster.cluster_master_username
  sensitive   = true
}

# aws_security_group
output "security_group_id" {
  description = "The security group ID of the cluster"
  value       = module.rds_cluster.security_group_id
}
