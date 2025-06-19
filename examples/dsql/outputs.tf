output "dsql_cluster_1_arn" {
  description = "ARN of the cluster"
  value       = module.dsql_cluster_1.arn
}

output "dsql_cluster_1_identifier" {
  description = "Cluster identifier"
  value       = module.dsql_cluster_1.identifier
}

output "dsql_cluster_1_encryption_details" {
  description = "Encryption configuration details for the DSQL cluster"
  value       = module.dsql_cluster_1.encryption_details
}

output "dsql_cluster_1_multi_region_properties" {
  description = "Multi-region properties of the DSQL cluster"
  value       = module.dsql_cluster_1.multi_region_properties
}

output "dsql_cluster_1_vpc_endpoint_service_name" {
  description = "The DSQL cluster's VPC endpoint service name"
  value       = module.dsql_cluster_1.vpc_endpoint_service_name
}

output "dsql_cluster_2_arn" {
  description = "ARN of the cluster"
  value       = module.dsql_cluster_2.arn
}

output "dsql_cluster_2_identifier" {
  description = "Cluster identifier"
  value       = module.dsql_cluster_2.identifier
}

output "dsql_cluster_2_encryption_details" {
  description = "Encryption configuration details for the DSQL cluster"
  value       = module.dsql_cluster_2.encryption_details
}

output "dsql_cluster_2_multi_region_properties" {
  description = "Multi-region properties of the DSQL cluster"
  value       = module.dsql_cluster_2.multi_region_properties
}

output "dsql_cluster_2_vpc_endpoint_service_name" {
  description = "The DSQL cluster's VPC endpoint service name"
  value       = module.dsql_cluster_2.vpc_endpoint_service_name
}
