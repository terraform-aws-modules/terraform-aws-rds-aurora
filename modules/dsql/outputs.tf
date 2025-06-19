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
