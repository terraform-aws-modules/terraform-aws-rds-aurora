################################################################################
# Cluster
################################################################################

output "arn" {
  description = "ARN of the cluster"
  value       = try(aws_dsql_cluster.this[0].arn, null)
}

output "identifier" {
  description = "Cluster identifier"
  value       = try(aws_dsql_cluster.this[0].identifier, null)
}

output "encryption_details" {
  description = "Encryption configuration details for the DSQL cluster"
  value       = try(aws_dsql_cluster.this[0].encryption_details, null)
}

output "multi_region_properties" {
  description = "Multi-region properties of the DSQL cluster"
  value       = try(aws_dsql_cluster.this[0].multi_region_properties, null)
}

output "vpc_endpoint_service_name" {
  description = "The DSQL cluster's VPC endpoint service name"
  value       = try(aws_dsql_cluster.this[0].vpc_endpoint_service_name, null)
}

################################################################################
# Cluster Policy
################################################################################

output "cluster_policy" {
  description = "The Aurora DSQL cluster resource-based policy document"
  value       = try(aws_dsql_cluster_policy.this[0].policy, null)
}

output "cluster_policy_version" {
  description = "The version of the Aurora DSQL cluster resource-based policy document"
  value       = try(aws_dsql_cluster_policy.this[0].policy_version, null)
}

################################################################################
# IAM Policy
################################################################################

output "iam_policy_document" {
  description = "IAM policy document for DSQL cluster access"
  value       = try(data.aws_iam_policy_document.dsql_policy[0].json, null)
}
