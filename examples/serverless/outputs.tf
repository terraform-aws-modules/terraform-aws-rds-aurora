################################################################################
# RDS Aurora Module - PostgreSQL
################################################################################

# aws_db_subnet_group
output "postgresql_db_subnet_group_name" {
  description = "The db subnet group name"
  value       = module.aurora_postgresql.db_subnet_group_name
}

# aws_rds_cluster
output "postgresql_cluster_arn" {
  description = "Amazon Resource Name (ARN) of cluster"
  value       = module.aurora_postgresql.cluster_arn
}

output "postgresql_cluster_id" {
  description = "The RDS Cluster Identifier"
  value       = module.aurora_postgresql.cluster_id
}

output "postgresql_cluster_resource_id" {
  description = "The RDS Cluster Resource ID"
  value       = module.aurora_postgresql.cluster_resource_id
}

output "postgresql_cluster_members" {
  description = "List of RDS Instances that are a part of this cluster"
  value       = module.aurora_postgresql.cluster_members
}

output "postgresql_cluster_endpoint" {
  description = "Writer endpoint for the cluster"
  value       = module.aurora_postgresql.cluster_endpoint
}

output "postgresql_cluster_reader_endpoint" {
  description = "A read-only endpoint for the cluster, automatically load-balanced across replicas"
  value       = module.aurora_postgresql.cluster_reader_endpoint
}

output "postgresql_cluster_engine_version_actual" {
  description = "The running version of the cluster database"
  value       = module.aurora_postgresql.cluster_engine_version_actual
}

# database_name is not set on `aws_rds_cluster` resource if it was not specified, so can't be used in output
output "postgresql_cluster_database_name" {
  description = "Name for an automatically created database on cluster creation"
  value       = module.aurora_postgresql.cluster_database_name
}

output "postgresql_cluster_port" {
  description = "The database port"
  value       = module.aurora_postgresql.cluster_port
}

output "postgresql_cluster_master_password" {
  description = "The database master password"
  value       = module.aurora_postgresql.cluster_master_password
  sensitive   = true
}

output "postgresql_cluster_master_username" {
  description = "The database master username"
  value       = module.aurora_postgresql.cluster_master_username
  sensitive   = true
}

output "postgresql_cluster_hosted_zone_id" {
  description = "The Route53 Hosted Zone ID of the endpoint"
  value       = module.aurora_postgresql.cluster_hosted_zone_id
}

# aws_rds_cluster_instances
output "postgresql_cluster_instances" {
  description = "A map of cluster instances and their attributes"
  value       = module.aurora_postgresql.cluster_instances
}

# aws_rds_cluster_endpoint
output "postgresql_additional_cluster_endpoints" {
  description = "A map of additional cluster endpoints and their attributes"
  value       = module.aurora_postgresql.additional_cluster_endpoints
}

# aws_rds_cluster_role_association
output "postgresql_cluster_role_associations" {
  description = "A map of IAM roles associated with the cluster and their attributes"
  value       = module.aurora_postgresql.cluster_role_associations
}

# Enhanced monitoring role
output "postgresql_enhanced_monitoring_iam_role_name" {
  description = "The name of the enhanced monitoring role"
  value       = module.aurora_postgresql.enhanced_monitoring_iam_role_name
}

output "postgresql_enhanced_monitoring_iam_role_arn" {
  description = "The Amazon Resource Name (ARN) specifying the enhanced monitoring role"
  value       = module.aurora_postgresql.enhanced_monitoring_iam_role_arn
}

output "postgresql_enhanced_monitoring_iam_role_unique_id" {
  description = "Stable and unique string identifying the enhanced monitoring role"
  value       = module.aurora_postgresql.enhanced_monitoring_iam_role_unique_id
}

# aws_security_group
output "postgresql_security_group_id" {
  description = "The security group ID of the cluster"
  value       = module.aurora_postgresql.security_group_id
}

################################################################################
# RDS Aurora Module - MySQL
################################################################################

# aws_db_subnet_group
output "mysql_db_subnet_group_name" {
  description = "The db subnet group name"
  value       = module.aurora_mysql.db_subnet_group_name
}

# aws_rds_cluster
output "mysql_cluster_arn" {
  description = "Amazon Resource Name (ARN) of cluster"
  value       = module.aurora_mysql.cluster_arn
}

output "mysql_cluster_id" {
  description = "The RDS Cluster Identifier"
  value       = module.aurora_mysql.cluster_id
}

output "mysql_cluster_resource_id" {
  description = "The RDS Cluster Resource ID"
  value       = module.aurora_mysql.cluster_resource_id
}

output "mysql_cluster_members" {
  description = "List of RDS Instances that are a part of this cluster"
  value       = module.aurora_mysql.cluster_members
}

output "mysql_cluster_endpoint" {
  description = "Writer endpoint for the cluster"
  value       = module.aurora_mysql.cluster_endpoint
}

output "mysql_cluster_reader_endpoint" {
  description = "A read-only endpoint for the cluster, automatically load-balanced across replicas"
  value       = module.aurora_mysql.cluster_reader_endpoint
}

output "mysql_cluster_engine_version_actual" {
  description = "The running version of the cluster database"
  value       = module.aurora_mysql.cluster_engine_version_actual
}

# database_name is not set on `aws_rds_cluster` resource if it was not specified, so can't be used in output
output "mysql_cluster_database_name" {
  description = "Name for an automatically created database on cluster creation"
  value       = module.aurora_mysql.cluster_database_name
}

output "mysql_cluster_port" {
  description = "The database port"
  value       = module.aurora_mysql.cluster_port
}

output "mysql_cluster_master_password" {
  description = "The database master password"
  value       = module.aurora_mysql.cluster_master_password
  sensitive   = true
}

output "mysql_cluster_master_username" {
  description = "The database master username"
  value       = module.aurora_mysql.cluster_master_username
  sensitive   = true
}

output "mysql_cluster_hosted_zone_id" {
  description = "The Route53 Hosted Zone ID of the endpoint"
  value       = module.aurora_mysql.cluster_hosted_zone_id
}

# aws_rds_cluster_instances
output "mysql_cluster_instances" {
  description = "A map of cluster instances and their attributes"
  value       = module.aurora_mysql.cluster_instances
}

# aws_rds_cluster_endpoint
output "mysql_additional_cluster_endpoints" {
  description = "A map of additional cluster endpoints and their attributes"
  value       = module.aurora_mysql.additional_cluster_endpoints
}

# aws_rds_cluster_role_association
output "mysql_cluster_role_associations" {
  description = "A map of IAM roles associated with the cluster and their attributes"
  value       = module.aurora_mysql.cluster_role_associations
}

# Enhanced monitoring role
output "mysql_enhanced_monitoring_iam_role_name" {
  description = "The name of the enhanced monitoring role"
  value       = module.aurora_mysql.enhanced_monitoring_iam_role_name
}

output "mysql_enhanced_monitoring_iam_role_arn" {
  description = "The Amazon Resource Name (ARN) specifying the enhanced monitoring role"
  value       = module.aurora_mysql.enhanced_monitoring_iam_role_arn
}

output "mysql_enhanced_monitoring_iam_role_unique_id" {
  description = "Stable and unique string identifying the enhanced monitoring role"
  value       = module.aurora_mysql.enhanced_monitoring_iam_role_unique_id
}

# aws_security_group
output "mysql_security_group_id" {
  description = "The security group ID of the cluster"
  value       = module.aurora_mysql.security_group_id
}


################################################################################
# RDS Aurora Module - MySQL Serverless V2
################################################################################

# aws_db_subnet_group
output "aurora_mysql_v2_db_subnet_group_name" {
  description = "The db subnet group name"
  value       = module.aurora_mysql_v2.db_subnet_group_name
}

# aws_rds_cluster
output "aurora_mysql_v2_cluster_arn" {
  description = "Amazon Resource Name (ARN) of cluster"
  value       = module.aurora_mysql_v2.cluster_arn
}

output "aurora_mysql_v2_cluster_id" {
  description = "The RDS Cluster Identifier"
  value       = module.aurora_mysql_v2.cluster_id
}

output "aurora_mysql_v2_cluster_resource_id" {
  description = "The RDS Cluster Resource ID"
  value       = module.aurora_mysql_v2.cluster_resource_id
}

output "aurora_mysql_v2_cluster_members" {
  description = "List of RDS Instances that are a part of this cluster"
  value       = module.aurora_mysql_v2.cluster_members
}

output "aurora_mysql_v2_cluster_endpoint" {
  description = "Writer endpoint for the cluster"
  value       = module.aurora_mysql_v2.cluster_endpoint
}

output "aurora_mysql_v2_cluster_reader_endpoint" {
  description = "A read-only endpoint for the cluster, automatically load-balanced across replicas"
  value       = module.aurora_mysql_v2.cluster_reader_endpoint
}

output "aurora_mysql_v2_cluster_engine_version_actual" {
  description = "The running version of the cluster database"
  value       = module.aurora_mysql_v2.cluster_engine_version_actual
}

# database_name is not set on `aws_rds_cluster` resource if it was not specified, so can't be used in output
output "aurora_mysql_v2_cluster_database_name" {
  description = "Name for an automatically created database on cluster creation"
  value       = module.aurora_mysql_v2.cluster_database_name
}

output "aurora_mysql_v2_cluster_port" {
  description = "The database port"
  value       = module.aurora_mysql_v2.cluster_port
}

output "aurora_mysql_v2_cluster_master_password" {
  description = "The database master password"
  value       = module.aurora_mysql_v2.cluster_master_password
  sensitive   = true
}

output "aurora_mysql_v2_cluster_master_username" {
  description = "The database master username"
  value       = module.aurora_mysql_v2.cluster_master_username
  sensitive   = true
}

output "aurora_mysql_v2_cluster_hosted_zone_id" {
  description = "The Route53 Hosted Zone ID of the endpoint"
  value       = module.aurora_mysql_v2.cluster_hosted_zone_id
}

# aws_rds_cluster_instances
output "aurora_mysql_v2_cluster_instances" {
  description = "A map of cluster instances and their attributes"
  value       = module.aurora_mysql_v2.cluster_instances
}

# aws_rds_cluster_endpoint
output "aurora_mysql_v2_additional_cluster_endpoints" {
  description = "A map of additional cluster endpoints and their attributes"
  value       = module.aurora_mysql_v2.additional_cluster_endpoints
}

# aws_rds_cluster_role_association
output "aurora_mysql_v2_cluster_role_associations" {
  description = "A map of IAM roles associated with the cluster and their attributes"
  value       = module.aurora_mysql_v2.cluster_role_associations
}

# Enhanced monitoring role
output "aurora_mysql_v2_enhanced_monitoring_iam_role_name" {
  description = "The name of the enhanced monitoring role"
  value       = module.aurora_mysql_v2.enhanced_monitoring_iam_role_name
}

output "aurora_mysql_v2_enhanced_monitoring_iam_role_arn" {
  description = "The Amazon Resource Name (ARN) specifying the enhanced monitoring role"
  value       = module.aurora_mysql_v2.enhanced_monitoring_iam_role_arn
}

output "aurora_mysql_v2_enhanced_monitoring_iam_role_unique_id" {
  description = "Stable and unique string identifying the enhanced monitoring role"
  value       = module.aurora_mysql_v2.enhanced_monitoring_iam_role_unique_id
}

# aws_security_group
output "aurora_mysql_v2_security_group_id" {
  description = "The security group ID of the cluster"
  value       = module.aurora_mysql_v2.security_group_id
}

################################################################################
# RDS Aurora Module - PostgreSQL Serverless V2
################################################################################

# aws_db_subnet_group
output "aurora_postgresql_v2_db_subnet_group_name" {
  description = "The db subnet group name"
  value       = module.aurora_postgresql_v2.db_subnet_group_name
}

# aws_rds_cluster
output "aurora_postgresql_v2_cluster_arn" {
  description = "Amazon Resource Name (ARN) of cluster"
  value       = module.aurora_postgresql_v2.cluster_arn
}

output "aurora_postgresql_v2_cluster_id" {
  description = "The RDS Cluster Identifier"
  value       = module.aurora_postgresql_v2.cluster_id
}

output "aurora_postgresql_v2_cluster_resource_id" {
  description = "The RDS Cluster Resource ID"
  value       = module.aurora_postgresql_v2.cluster_resource_id
}

output "aurora_postgresql_v2_cluster_members" {
  description = "List of RDS Instances that are a part of this cluster"
  value       = module.aurora_postgresql_v2.cluster_members
}

output "aurora_postgresql_v2_cluster_endpoint" {
  description = "Writer endpoint for the cluster"
  value       = module.aurora_postgresql_v2.cluster_endpoint
}

output "aurora_postgresql_v2_cluster_reader_endpoint" {
  description = "A read-only endpoint for the cluster, automatically load-balanced across replicas"
  value       = module.aurora_postgresql_v2.cluster_reader_endpoint
}

output "aurora_postgresql_v2_cluster_engine_version_actual" {
  description = "The running version of the cluster database"
  value       = module.aurora_postgresql_v2.cluster_engine_version_actual
}

# database_name is not set on `aws_rds_cluster` resource if it was not specified, so can't be used in output
output "aurora_postgresql_v2_cluster_database_name" {
  description = "Name for an automatically created database on cluster creation"
  value       = module.aurora_postgresql_v2.cluster_database_name
}

output "aurora_postgresql_v2_cluster_port" {
  description = "The database port"
  value       = module.aurora_postgresql_v2.cluster_port
}

output "aurora_postgresql_v2_cluster_master_password" {
  description = "The database master password"
  value       = module.aurora_postgresql_v2.cluster_master_password
  sensitive   = true
}

output "aurora_postgresql_v2_cluster_master_username" {
  description = "The database master username"
  value       = module.aurora_postgresql_v2.cluster_master_username
  sensitive   = true
}

output "aurora_postgresql_v2_cluster_hosted_zone_id" {
  description = "The Route53 Hosted Zone ID of the endpoint"
  value       = module.aurora_postgresql_v2.cluster_hosted_zone_id
}

# aws_rds_cluster_instances
output "aurora_postgresql_v2_cluster_instances" {
  description = "A map of cluster instances and their attributes"
  value       = module.aurora_postgresql_v2.cluster_instances
}

# aws_rds_cluster_endpoint
output "aurora_postgresql_v2_additional_cluster_endpoints" {
  description = "A map of additional cluster endpoints and their attributes"
  value       = module.aurora_postgresql_v2.additional_cluster_endpoints
}

# aws_rds_cluster_role_association
output "aurora_postgresql_v2_cluster_role_associations" {
  description = "A map of IAM roles associated with the cluster and their attributes"
  value       = module.aurora_postgresql_v2.cluster_role_associations
}

# Enhanced monitoring role
output "aurora_postgresql_v2_enhanced_monitoring_iam_role_name" {
  description = "The name of the enhanced monitoring role"
  value       = module.aurora_postgresql_v2.enhanced_monitoring_iam_role_name
}

output "aurora_postgresql_v2_enhanced_monitoring_iam_role_arn" {
  description = "The Amazon Resource Name (ARN) specifying the enhanced monitoring role"
  value       = module.aurora_postgresql_v2.enhanced_monitoring_iam_role_arn
}

output "aurora_postgresql_v2_enhanced_monitoring_iam_role_unique_id" {
  description = "Stable and unique string identifying the enhanced monitoring role"
  value       = module.aurora_postgresql_v2.enhanced_monitoring_iam_role_unique_id
}

# aws_security_group
output "aurora_postgresql_v2_security_group_id" {
  description = "The security group ID of the cluster"
  value       = module.aurora_postgresql_v2.security_group_id
}
