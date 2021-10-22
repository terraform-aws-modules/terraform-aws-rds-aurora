# aws_rds_cluster
output "rds_cluster_arn" {
  description = "The ID of the cluster"
  value       = try(aws_rds_cluster.this[0].arn, "")
}

output "rds_cluster_id" {
  description = "The ID of the cluster"
  value       = try(aws_rds_cluster.this[0].id, "")
}

output "rds_cluster_resource_id" {
  description = "The Resource ID of the cluster"
  value       = try(aws_rds_cluster.this[0].cluster_resource_id, "")
}

output "rds_cluster_endpoint" {
  description = "The cluster endpoint"
  value       = try(aws_rds_cluster.this[0].endpoint, "")
}

output "rds_cluster_engine_version" {
  description = "The cluster engine version"
  value       = try(aws_rds_cluster.this[0].engine_version, "")
}

output "rds_cluster_reader_endpoint" {
  description = "The cluster reader endpoint"
  value       = try(aws_rds_cluster.this[0].reader_endpoint, "")
}

# database_name is not set on `aws_rds_cluster` resource if it was not specified, so can't be used in output
output "rds_cluster_database_name" {
  description = "Name for an automatically created database on cluster creation"
  value       = var.database_name
}

output "rds_cluster_master_password" {
  description = "The master password"
  value       = try(aws_rds_cluster.this[0].master_password, "")
  sensitive   = true
}

output "rds_cluster_port" {
  description = "The port"
  value       = try(aws_rds_cluster.this[0].port, "")
}

output "rds_cluster_master_username" {
  description = "The master username"
  value       = try(aws_rds_cluster.this[0].master_username, "")
  sensitive   = true
}

output "rds_cluster_hosted_zone_id" {
  description = "Route53 hosted zone id of the created cluster"
  value       = try(aws_rds_cluster.this[0].hosted_zone_id, "")
}

# aws_rds_cluster_instances
output "rds_cluster_instances" {
  description = "A map of cluster instances and their attributes"
  value       = aws_rds_cluster_instance.this
}

# aws_security_group
output "security_group_id" {
  description = "The security group ID of the cluster"
  value       = local.rds_security_group_id
}

# Enhanced monitoring role
output "enhanced_monitoring_iam_role_name" {
  description = "The name of the enhanced monitoring role"
  value       = try(aws_iam_role.rds_enhanced_monitoring[0].name, "")
}

output "enhanced_monitoring_iam_role_arn" {
  description = "The Amazon Resource Name (ARN) specifying the enhanced monitoring role"
  value       = try(aws_iam_role.rds_enhanced_monitoring[0].arn, "")
}

output "enhanced_monitoring_iam_role_unique_id" {
  description = "Stable and unique string identifying the enhanced monitoring role"
  value       = try(aws_iam_role.rds_enhanced_monitoring[0].unique_id, "")
}
