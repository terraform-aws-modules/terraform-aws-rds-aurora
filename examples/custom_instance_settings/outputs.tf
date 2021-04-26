# aws_rds_cluster
output "rds_cluster_id" {
  description = "The ID of the cluster"
  value       = module.aurora.rds_cluster_id
}

output "rds_cluster_resource_id" {
  description = "The Resource ID of the cluster"
  value       = module.aurora.rds_cluster_resource_id
}

output "rds_cluster_endpoint" {
  description = "The cluster endpoint"
  value       = module.aurora.rds_cluster_endpoint
}

output "rds_cluster_reader_endpoint" {
  description = "The cluster reader endpoint"
  value       = module.aurora.rds_cluster_reader_endpoint
}

output "rds_cluster_database_name" {
  description = "Name for an automatically created database on cluster creation"
  value       = module.aurora.rds_cluster_database_name
}

output "rds_cluster_master_password" {
  description = "The master password"
  value       = module.aurora.rds_cluster_master_password
  sensitive   = true
}

output "rds_cluster_port" {
  description = "The port"
  value       = module.aurora.rds_cluster_port
}

output "rds_cluster_master_username" {
  description = "The master username"
  value       = module.aurora.rds_cluster_master_username
  sensitive   = true
}

# aws_rds_cluster_instance
output "rds_cluster_instance_endpoints" {
  description = "A list of all cluster instance endpoints"
  value       = module.aurora.rds_cluster_instance_endpoints
}

# aws_security_group
output "security_group_id" {
  description = "The security group ID of the cluster"
  value       = module.aurora.security_group_id
}

