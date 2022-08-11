provider "aws" {
  region = local.region
}

locals {
  name   = "example-${replace(basename(path.cwd), "_", "-")}"
  region = "eu-west-1"
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

  name           = local.name
  engine         = "aurora-postgresql"
  engine_version = "11.12"
  instances = {
    1 = {
      instance_class      = "db.r5.2xlarge"
      publicly_accessible = true
    }
    2 = {
      identifier     = "static-member-1"
      instance_class = "db.r5.2xlarge"
    }
    3 = {
      identifier     = "excluded-member-1"
      instance_class = "db.r5.large"
      promotion_tier = 15
    }
  }

  endpoints = {
    static = {
      identifier     = "static-custom-endpt"
      type           = "ANY"
      static_members = ["static-member-1"]
      tags           = { Endpoint = "static-members" }
    }
    excluded = {
      identifier       = "excluded-custom-endpt"
      type             = "READER"
      excluded_members = ["excluded-member-1"]
      tags             = { Endpoint = "excluded-members" }
    }
  }

  vpc_id                 = module.vpc.vpc_id
  db_subnet_group_name   = module.vpc.database_subnet_group_name
  create_db_subnet_group = false
  create_security_group  = true
  allowed_cidr_blocks    = module.vpc.private_subnets_cidr_blocks
  security_group_egress_rules = {
    to_cidrs = {
      cidr_blocks = ["10.33.0.0/28"]
      description = "Egress to corporate printer closet"
    }
  }

  iam_database_authentication_enabled = true
  master_password                     = random_password.master.result
  create_random_password              = false

  apply_immediately   = true
  skip_final_snapshot = true

  db_parameter_group_name           = "db-pg-aurora2"
  db_cluster_parameter_group_name   = "db-aurora2-cluster-pg"
  create_db_cluster_parameter_group = true
  create_db_parameter_group         = true
  db_cluster_parameter_group = {
    family              = "aurora-postgresql"
    description_cluster = "dev-rds-1-aurora2-cluster Aurora2 5.7 DB Cluster Parameter Group"
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
  }
  db_parameter_group = {
    family               = "aurora-postgresql"
    description_instance = "dev-rds-1-aurora2 Aurora2 5.7 DB Parameter Group"
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
  }
  enabled_cloudwatch_logs_exports = ["postgresql"]

  tags = local.tags
}
