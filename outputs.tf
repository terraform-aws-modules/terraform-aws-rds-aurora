// aws_rds_cluster
output "this_rds_cluster_id" {
  description = "The ID of the cluster"
  value       = "${aws_rds_cluster.this.id}"
}

output "this_rds_cluster_arn" {
  description = "Amazon Resource Name (ARN) of cluster"
  value       = "${aws_rds_cluster.this.arn}"
}

output "this_rds_cluster_resource_id" {
  description = "The Resource ID of the cluster"
  value       = "${aws_rds_cluster.this.cluster_resource_id}"
}

output "this_rds_cluster_endpoint" {
  description = "The cluster endpoint"
  value       = "${aws_rds_cluster.this.endpoint}"
}

output "this_rds_cluster_reader_endpoint" {
  description = "The cluster reader endpoint"
  value       = "${aws_rds_cluster.this.reader_endpoint}"
}

// database_name is not set on `aws_rds_cluster` resource if it was not specified, so can't be used in output
output "this_rds_cluster_database_name" {
  description = "Name for an automatically created database on cluster creation"
  value       = "${var.database_name}"
}

output "this_rds_cluster_master_password" {
  description = "The master password"
  value       = "${aws_rds_cluster.this.master_password}"
}

output "this_rds_cluster_port" {
  description = "The port"
  value       = "${aws_rds_cluster.this.port}"
}

output "this_rds_cluster_master_username" {
  description = "The master username"
  value       = "${aws_rds_cluster.this.master_username}"
}

// Commented out because of this issue - https://github.com/terraform-providers/terraform-provider-aws/issues/10290
// Error: Error running plan: 1 error occurred:
//	* Resource 'aws_rds_cluster.this' does not have attribute 'replication_source_identifier' for variable 'aws_rds_cluster.this.replication_source_identifier'
//output "this_rds_cluster_replication_source_identifier" {
//  description = "ARN of the source DB cluster or DB instance if this DB cluster is created as a Read Replica."
//  value       = "${aws_rds_cluster.this.replication_source_identifier}"
//}

// aws_rds_cluster_instance
output "this_rds_cluster_instance_endpoints" {
  description = "A list of all cluster instance endpoints"
  value       = ["${aws_rds_cluster_instance.this.*.endpoint}"]
}

// aws_security_group
output "this_security_group_id" {
  description = "The security group ID of the cluster"
  value       = "${aws_security_group.this.id}"
}
