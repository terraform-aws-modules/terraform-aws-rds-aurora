output "this_rds_cluster_id" {
  description = "The ID of the cluster"
  value       = "${element(split(",", join(",", aws_rds_cluster.this.*.id)), 0)}"
}

output "this_rds_cluster_endpoint" {
  description = "The cluster endpoint"
  value       = "${element(split(",", join(",", aws_rds_cluster.this.*.endpoint)), 0)}"
}

output "this_rds_cluster_reader_endpoint" {
  description = "The cluster reader endpoint"
  value       = "${element(split(",", join(",", aws_rds_cluster.this.*.reader_endpoint)), 0)}"
}

output "this_rds_cluster_master_username" {
  description = "The master username"
  value       = "${element(split(",", join(",", aws_rds_cluster.this.*.master_username)), 0)}"
}

output "this_rds_cluster_master_password" {
  description = "The master password"
  value       = "${element(split(",", join(",", aws_rds_cluster.this.*.master_password)), 0)}"
}

output "this_rds_cluster_port" {
  description = "The port"
  value       = "${element(split(",", join(",", aws_rds_cluster.this.*.port)), 0)}"
}

output "this_rds_cluster_instance_endpoints" {
  description = "A list of all cluster instance endpoints"
  value       = ["${aws_rds_cluster_instance.this.*.endpoint}"]
}

output "this_security_group_id" {
  description = "The security group ID of the cluster"
  value       = "${element(split(",", join(",", aws_security_group.this.*.id)), 0)}"
}
