// aws_rds_cluster
output "this_rds_cluster_arn" {
  description = "The ID of the cluster"
  value       = element(concat(aws_rds_cluster.this.*.arn, aws_rds_cluster.this-s3-restore.*.arn), 0)
}

output "this_rds_cluster_id" {
  description = "The ID of the cluster"
  value       = element(concat(aws_rds_cluster.this.*.id, aws_rds_cluster.this-s3-restore.*.id), 0)
}

output "this_rds_cluster_resource_id" {
  description = "The Resource ID of the cluster"
  value       = element(concat(aws_rds_cluster.this.*.cluster_resource_id, aws_rds_cluster.this-s3-restore.*.cluster_resource_id), 0)
}

output "this_rds_cluster_endpoint" {
  description = "The cluster endpoint"
  value       = element(concat(aws_rds_cluster.this.*.endpoint, aws_rds_cluster.this-s3-restore.*.endpoint), 0)
}

output "this_rds_cluster_reader_endpoint" {
  description = "The cluster reader endpoint"
  value       = element(concat(aws_rds_cluster.this.*.reader_endpoint, aws_rds_cluster.this-s3-restore.*.reader_endpoint), 0)
}

// database_name is not set on `aws_rds_cluster` resource if it was not specified, so can't be used in output
output "this_rds_cluster_database_name" {
  description = "Name for an automatically created database on cluster creation"
  value       = var.database_name
}

output "this_rds_cluster_master_password" {
  description = "The master password"
  value       = element(concat(aws_rds_cluster.this.*.master_password, aws_rds_cluster.this-s3-restore.*.master_password), 0)
  sensitive   = true
}

output "this_rds_cluster_port" {
  description = "The port"
  value       = element(concat(aws_rds_cluster.this.*.port, aws_rds_cluster.this-s3-restore.*.port), 0)
}

output "this_rds_cluster_master_username" {
  description = "The master username"
  value       = element(concat(aws_rds_cluster.this.*.master_username, aws_rds_cluster.this-s3-restore.*.master_username), 0)
}

// aws_rds_cluster_instance
output "this_rds_cluster_instance_endpoints" {
  description = "A list of all cluster instance endpoints"
  value       = aws_rds_cluster_instance.this.*.endpoint
}

// aws_security_group
output "this_security_group_id" {
  description = "The security group ID of the cluster"
  value       = local.rds_security_group_id
}

