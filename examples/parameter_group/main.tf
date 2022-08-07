provider "aws" {
  region = local.region
}

locals {
  name   = "example-${replace(basename(path.cwd), "_", "-")}"
  region = "us-east-1"
  tags = {
    Owner       = "user"
    Environment = "dev"
  }
}

################################################################################
# Supporting Resources
################################################################################

resource "random_password" "master" {
  length = 10
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 3.0"

  name = local.name
  cidr = "10.99.0.0/18"

  enable_dns_support   = true
  enable_dns_hostnames = true

  azs              = ["${local.region}a", "${local.region}b", "${local.region}c"]
  public_subnets   = ["10.99.0.0/24", "10.99.1.0/24", "10.99.2.0/24"]
  private_subnets  = ["10.99.3.0/24", "10.99.4.0/24", "10.99.5.0/24"]
  database_subnets = ["10.99.7.0/24", "10.99.8.0/24", "10.99.9.0/24"]

  tags = local.tags
}

################################################################################
# RDS Aurora Module
################################################################################

module "aurora" {
  source = "../../"
  name   = local.name
  instances = {
    1 = {
      identifier     = "mysql-static-1"
      instance_class = "db.r5.xlarge"
    }
    2 = {
      identifier     = "mysql-static-2"
      instance_class = "db.r5.xlarge"
    }
  }
  instances_use_identifier_prefix = false
  engine                          = "aurora-mysql"
  engine_version                  = "5.7"
  instance_class                  = "db.r5.xlarge"
  create_random_password          = false
  master_password                 = random_password.master.result
  db_parameter_group_name         = "db-pg-aurora2"
  db_cluster_parameter_group_name = "db-aurora2-cluster-pg"
  parameter_group_settings = {
    pg_family = "aurora-mysql5.7"
    parameters_cluster = {
      "aurora_disable_hash_join"                              = { "1" = "immediate" }
      "aurora_load_from_s3_role"                              = { "arn:aws:iam::095326208734:role/rds-aurora-logs-to-s3" = "immediate" }
      "aurora_select_into_s3_role"                            = { "arn:aws:iam::095326208734:role/rds-aurora-logs-to-s3" = "immediate" }
      "aws_default_lambda_role"                               = { "arn:aws:iam::095326208734:role/dev-rds-lambda" = "immediate" }
      "aws_default_s3_role"                                   = { "arn:aws:iam::095326208734:role/rds-aurora-logs-to-s3" = "immediate" }
      "binlog_checksum"                                       = { "NONE" = "immediate" }
      "connect_timeout"                                       = { "120" = "immediate" }
      "innodb_lock_wait_timeout"                              = { "300" = "immediate" }
      "log_output"                                            = { "FILE" = "immediate" }
      "max_allowed_packet"                                    = { "67108864" = "immediate" }
      "server_audit_events"                                   = { "QUERY" = "immediate" }
      "server_audit_excl_users"                               = { "rdsadmin" = "immediate" }
      "server_audit_logging"                                  = { "1" = "immediate" }
      "server_audit_logs_upload"                              = { "1" = "immediate" }
      "aurora_parallel_query"                                 = { "OFF" = "pending-reboot" }
      "binlog_format"                                         = { "ROW" = "pending-reboot" }
      "log_bin_trust_function_creators"                       = { "1" = "immediate" }
      "require_secure_transport"                              = { "ON" = "immediate" }
      "tls_version"                                           = { "TLSv1.2" = "pending-reboot" }
      "server_audit_events"                                   = { "CONNECT,QUERY" = "immediate" }
      "performance_schema"                                    = { "1" = "pending-reboot" }
      "performance_schema_consumer_events_statements_current" = { "1" = "pending-reboot" }
      "performance_schema_consumer_events_statements_history" = { "1" = "pending-reboot" }
    }
    parameters_instance = {
      "connect_timeout"                 = { "60" = "immediate" }
      "general_log"                     = { "0" = "immediate" }
      "innodb_lock_wait_timeout"        = { "300" = "immediate" }
      "log_output"                      = { "FILE" = "immediate" }
      "long_query_time"                 = { "5" = "immediate" }
      "max_connections"                 = { "2000" = "immediate" }
      "slow_query_log"                  = { "1" = "immediate" }
      "log_bin_trust_function_creators" = { "1" = "immediate" }
    }
    pg_description_cluster  = "dev-rds-1-aurora2-cluster Aurora2 5.7 DB Cluster Parameter Group"
    pg_description_instance = "dev-rds-1-aurora2 Aurora2 5.7 DB Parameter Group"
  }
  autoscaling_enabled             = "true"
  autoscaling_policy_name         = "${local.name}-autoscaling"
  autoscaling_target_cpu          = 75
  autoscaling_max_capacity        = 15
  autoscaling_min_capacity        = 0
  enabled_cloudwatch_logs_exports = ["audit", "error", "general", "slowquery"]
  vpc_id                          = module.vpc.vpc_id
  create_security_group           = true
  db_subnet_group_name            = module.vpc.database_subnet_group_name
  skip_final_snapshot             = true
  copy_tags_to_snapshot           = true
  create_db_subnet_group          = false
  tags                            = local.tags
}
