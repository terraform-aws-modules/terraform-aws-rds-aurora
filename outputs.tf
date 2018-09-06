// aws_rds_cluster
output "this_rds_cluster_id" {
  description = "The ID of the cluster"
  value       = "${aws_rds_cluster.this.id}"
}

output "this_rds_cluster_endpoint" {
  description = "The cluster endpoint"
  value       = "${aws_rds_cluster.this.endpoint}"
}

output "this_rds_cluster_reader_endpoint" {
  description = "The cluster reader endpoint"
  value       = "${aws_rds_cluster.this.reader_endpoint}"
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
