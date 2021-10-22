# aws_rds_cluster
output "primary_cluster_id" {
  description = "The ID of the cluster"
  value       = module.primary_aurora.rds_cluster_id
}

output "primary_cluster_resource_id" {
  description = "The Resource ID of the cluster"
  value       = module.primary_aurora.rds_cluster_resource_id
}

output "primary_cluster_endpoint" {
  description = "The cluster endpoint"
  value       = module.primary_aurora.rds_cluster_endpoint
}

output "primary_cluster_reader_endpoint" {
  description = "The cluster reader endpoint"
  value       = module.primary_aurora.rds_cluster_reader_endpoint
}

output "primary_cluster_database_name" {
  description = "Name for an automatically created database on cluster creation"
  value       = module.primary_aurora.rds_cluster_database_name
}

output "primary_cluster_master_password" {
  description = "The master password"
  value       = module.primary_aurora.rds_cluster_master_password
  sensitive   = true
}

output "primary_cluster_port" {
  description = "The port"
  value       = module.primary_aurora.rds_cluster_port
}

output "primary_cluster_master_username" {
  description = "The master username"
  value       = module.primary_aurora.rds_cluster_master_username
  sensitive   = true
}

# aws_rds_cluster_instance
output "primary_cluster_instance_endpoints" {
  description = "A list of all cluster instance endpoints"
  value       = module.primary_aurora.rds_cluster_instance_endpoints
}

output "primary_cluster_instance_ids" {
  description = "A list of all cluster instance ids"
  value       = module.primary_aurora.rds_cluster_instance_ids
}

output "primary_cluster_instance_dbi_resource_ids" {
  description = "A list of all the region-unique, immutable identifiers for the DB instances"
  value       = module.primary_aurora.rds_cluster_instance_dbi_resource_ids
}

# aws_security_group
output "primary_security_group_id" {
  description = "The security group ID of the cluster"
  value       = module.primary_aurora.security_group_id
}

# aws_rds_cluster
output "secondary_cluster_id" {
  description = "The ID of the cluster"
  value       = module.secondary_aurora.rds_cluster_id
}

output "secondary_cluster_resource_id" {
  description = "The Resource ID of the cluster"
  value       = module.secondary_aurora.rds_cluster_resource_id
}

output "secondary_cluster_endpoint" {
  description = "The cluster endpoint"
  value       = module.secondary_aurora.rds_cluster_endpoint
}

output "secondary_cluster_reader_endpoint" {
  description = "The cluster reader endpoint"
  value       = module.secondary_aurora.rds_cluster_reader_endpoint
}

output "secondary_cluster_database_name" {
  description = "Name for an automatically created database on cluster creation"
  value       = module.secondary_aurora.rds_cluster_database_name
}

output "secondary_cluster_master_password" {
  description = "The master password"
  value       = module.secondary_aurora.rds_cluster_master_password
  sensitive   = true
}

output "secondary_cluster_port" {
  description = "The port"
  value       = module.secondary_aurora.rds_cluster_port
}

output "secondary_cluster_master_username" {
  description = "The master username"
  value       = module.secondary_aurora.rds_cluster_master_username
  sensitive   = true
}

# aws_rds_cluster_instance
output "secondary_cluster_instance_endpoints" {
  description = "A list of all cluster instance endpoints"
  value       = module.secondary_aurora.rds_cluster_instance_endpoints
}

output "secondary_cluster_instance_ids" {
  description = "A list of all cluster instance ids"
  value       = module.secondary_aurora.rds_cluster_instance_ids
}

output "secondary_cluster_instance_dbi_resource_ids" {
  description = "A list of all the region-unique, immutable identifiers for the DB instances"
  value       = module.secondary_aurora.rds_cluster_instance_dbi_resource_ids
}

# aws_security_group
output "secondary_security_group_id" {
  description = "The security group ID of the cluster"
  value       = module.secondary_aurora.security_group_id
}

# global cluster
output "global_cluster_members" {
  description = "Set of objects containing Global Cluster members"
  value       = aws_rds_global_cluster.this.global_cluster_members
}
