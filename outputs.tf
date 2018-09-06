output "endpoint" {
  value       = "${aws_rds_cluster.default.endpoint}"
  description = "The cluster endpoint"
}

output "reader_endpoint" {
  value       = "${aws_rds_cluster.default.reader_endpoint}"
  description = "The cluster reader endpoint"
}

output "instance_endpoints" {
  value       = ["${aws_rds_cluster_instance.cluster_instance.*.endpoint}"]
  description = "A list of all cluster instance endpoints"
}

output "rds_cluster_id" {
  value       = "${aws_rds_cluster.default.id}"
  description = "The ID of the cluster"
}

output "master_password" {
  sensitive   = true
  value       = "${aws_rds_cluster.default.master_password}"
  description = "The master password"
}

output "port" {
  value       = "${aws_rds_cluster.default.port}"
  description = "The port"
}

output "master_username" {
  value       = "${aws_rds_cluster.default.master_username}"
  description = "The master username"
}

output "security_group_id" {
  value       = "${aws_security_group.default.id}"
  description = "The security group ID of the cluster"
}
