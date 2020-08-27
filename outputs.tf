// aws_rds_cluster
output "this_rds_cluster_arn" {
  description = "The ID of the cluster"
  value       = aws_rds_cluster.this.arn
}

output "this_rds_cluster_id" {
  description = "The ID of the cluster"
  value       = aws_rds_cluster.this.id
}

output "this_rds_cluster_resource_id" {
  description = "The Resource ID of the cluster"
  value       = aws_rds_cluster.this.cluster_resource_id
}

output "this_rds_cluster_endpoint" {
  description = "The cluster endpoint"
  value       = aws_rds_cluster.this.endpoint
}

output "this_rds_cluster_reader_endpoint" {
  description = "The cluster reader endpoint"
  value       = aws_rds_cluster.this.reader_endpoint
}

// database_name is not set on `aws_rds_cluster` resource if it was not specified, so can't be used in output
output "this_rds_cluster_database_name" {
  description = "Name for an automatically created database on cluster creation"
  value       = var.database_name
}

output "this_rds_cluster_master_password" {
  description = "The master password"
  value       = aws_rds_cluster.this.master_password
  sensitive   = true
}

output "this_rds_cluster_port" {
  description = "The port"
  value       = aws_rds_cluster.this.port
}

output "this_rds_cluster_master_username" {
  description = "The master username"
  value       = aws_rds_cluster.this.master_username
}

output "this_rds_cluster_hosted_zone_id" {
  description = "Route53 hosted zone id of the created cluster"
  value       = aws_rds_cluster.this.hosted_zone_id
}

// aws_rds_cluster_instance
output "this_rds_cluster_instance_endpoints" {
  description = "A list of all cluster instance endpoints"
  value       = aws_rds_cluster_instance.this.*.endpoint
}

output "this_rds_cluster_instance_ids" {
  description = "A list of all cluster instance ids"
  value       = aws_rds_cluster_instance.this.*.id
}

// aws_security_group
output "this_security_group_id" {
  description = "The security group ID of the cluster"
  value       = local.rds_security_group_id
}
