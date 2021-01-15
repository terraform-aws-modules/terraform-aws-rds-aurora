# aws_rds_cluster
output "this_rds_cluster_arn" {
  description = "The ID of the cluster"
  value       = element(concat(aws_rds_cluster.this.*.arn, [""]), 0)
}

output "this_rds_cluster_id" {
  description = "The ID of the cluster"
  value       = element(concat(aws_rds_cluster.this.*.id, [""]), 0)
}

output "this_rds_cluster_resource_id" {
  description = "The Resource ID of the cluster"
  value       = element(concat(aws_rds_cluster.this.*.cluster_resource_id, [""]), 0)
}

output "this_rds_cluster_endpoint" {
  description = "The cluster endpoint"
  value       = element(concat(aws_rds_cluster.this.*.endpoint, [""]), 0)
}

output "this_rds_cluster_engine_version" {
  description = "The cluster engine version"
  value       = element(concat(aws_rds_cluster.this.*.engine_version, [""]), 0)
}

output "this_rds_cluster_reader_endpoint" {
  description = "The cluster reader endpoint"
  value       = element(concat(aws_rds_cluster.this.*.reader_endpoint, [""]), 0)
}

# database_name is not set on `aws_rds_cluster` resource if it was not specified, so can't be used in output
output "this_rds_cluster_database_name" {
  description = "Name for an automatically created database on cluster creation"
  value       = var.database_name
}

output "this_rds_cluster_master_password" {
  description = "The master password"
  value       = element(concat(aws_rds_cluster.this.*.master_password, [""]), 0)
  sensitive   = true
}

output "this_rds_cluster_port" {
  description = "The port"
  value       = element(concat(aws_rds_cluster.this.*.port, [""]), 0)
}

output "this_rds_cluster_master_username" {
  description = "The master username"
  value       = element(concat(aws_rds_cluster.this.*.master_username, [""]), 0)
}

output "this_rds_cluster_hosted_zone_id" {
  description = "Route53 hosted zone id of the created cluster"
  value       = element(concat(aws_rds_cluster.this.*.hosted_zone_id, [""]), 0)

}

# aws_rds_cluster_instance
output "this_rds_cluster_instance_endpoints" {
  description = "A list of all cluster instance endpoints"
  value       = aws_rds_cluster_instance.this.*.endpoint
}

output "this_rds_cluster_instance_ids" {
  description = "A list of all cluster instance ids"
  value       = aws_rds_cluster_instance.this.*.id
}

# aws_security_group
output "this_security_group_id" {
  description = "The security group ID of the cluster"
  value       = local.rds_security_group_id
}
