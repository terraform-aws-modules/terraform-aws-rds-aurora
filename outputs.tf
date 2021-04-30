# aws_rds_cluster
output "rds_cluster_arn" {
  description = "The ID of the cluster"
  value       = element(concat(aws_rds_cluster.this.*.arn, [""]), 0)
}

output "rds_cluster_id" {
  description = "The ID of the cluster"
  value       = element(concat(aws_rds_cluster.this.*.id, [""]), 0)
}

output "rds_cluster_resource_id" {
  description = "The Resource ID of the cluster"
  value       = element(concat(aws_rds_cluster.this.*.cluster_resource_id, [""]), 0)
}

output "rds_cluster_endpoint" {
  description = "The cluster endpoint"
  value       = element(concat(aws_rds_cluster.this.*.endpoint, [""]), 0)
}

output "rds_cluster_engine_version" {
  description = "The cluster engine version"
  value       = element(concat(aws_rds_cluster.this.*.engine_version, [""]), 0)
}

output "rds_cluster_reader_endpoint" {
  description = "The cluster reader endpoint"
  value       = element(concat(aws_rds_cluster.this.*.reader_endpoint, [""]), 0)
}

# database_name is not set on `aws_rds_cluster` resource if it was not specified, so can't be used in output
output "rds_cluster_database_name" {
  description = "Name for an automatically created database on cluster creation"
  value       = var.database_name
}

output "rds_cluster_master_password" {
  description = "The master password"
  value       = element(concat(aws_rds_cluster.this.*.master_password, [""]), 0)
  sensitive   = true
}

output "rds_cluster_port" {
  description = "The port"
  value       = element(concat(aws_rds_cluster.this.*.port, [""]), 0)
}

output "rds_cluster_master_username" {
  description = "The master username"
  value       = element(concat(aws_rds_cluster.this.*.master_username, [""]), 0)
  sensitive   = true
}

output "rds_cluster_hosted_zone_id" {
  description = "Route53 hosted zone id of the created cluster"
  value       = element(concat(aws_rds_cluster.this.*.hosted_zone_id, [""]), 0)
}

# aws_rds_cluster_instance
output "rds_cluster_instance_endpoints" {
  description = "A list of all cluster instance endpoints"
  value       = aws_rds_cluster_instance.this.*.endpoint
}

output "rds_cluster_instance_ids" {
  description = "A list of all cluster instance ids"
  value       = aws_rds_cluster_instance.this.*.id
}

output "rds_cluster_instance_dbi_resource_ids" {
  description = "A list of all the region-unique, immutable identifiers for the DB instances"
  value       = aws_rds_cluster_instance.this.*.dbi_resource_id
}

# aws_security_group
output "security_group_id" {
  description = "The security group ID of the cluster"
  value       = local.rds_security_group_id
}

# Enhanced monitoring role
output "enhanced_monitoring_iam_role_name" {
  description = "The name of the enhanced monitoring role"
  value       = element(concat(aws_iam_role.rds_enhanced_monitoring.*.name, [""]), 0)
}

output "enhanced_monitoring_iam_role_arn" {
  description = "The Amazon Resource Name (ARN) specifying the enhanced monitoring role"
  value       = element(concat(aws_iam_role.rds_enhanced_monitoring.*.arn, [""]), 0)
}

output "enhanced_monitoring_iam_role_unique_id" {
  description = "Stable and unique string identifying the enhanced monitoring role"
  value       = element(concat(aws_iam_role.rds_enhanced_monitoring.*.unique_id, [""]), 0)
}
