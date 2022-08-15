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
  engine         = "aurora-mysql"
  engine_version = "5.7"
  instances = {
    1 = {
      instance_class      = "db.r5.large"
      publicly_accessible = true
    }
    2 = {
      identifier     = "mysql-static-1"
      instance_class = "db.r5.2xlarge"
    }
    3 = {
      identifier     = "mysql-excluded-1"
      instance_class = "db.r5.xlarge"
      promotion_tier = 15
    }
  }

  vpc_id                 = module.vpc.vpc_id
  db_subnet_group_name   = module.vpc.database_subnet_group_name
  create_db_subnet_group = false
  create_security_group  = true
  allowed_cidr_blocks    = module.vpc.private_subnets_cidr_blocks

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
    family              = "aurora-mysql5.7"
    description_cluster = "dev-rds-1-aurora2-cluster Aurora2 5.7 DB Cluster Parameter Group"
    parameters_cluster = {
      "connect_timeout"                 = { "120" = "immediate" }
      "innodb_lock_wait_timeout"        = { "300" = "immediate" }
      "log_output"                      = { "FILE" = "immediate" }
      "max_allowed_packet"              = { "67108864" = "immediate" }
      "aurora_parallel_query"           = { "OFF" = "pending-reboot" }
      "binlog_format"                   = { "ROW" = "pending-reboot" }
      "log_bin_trust_function_creators" = { "1" = "immediate" }
      "require_secure_transport"        = { "ON" = "immediate" }
      "tls_version"                     = { "TLSv1.2" = "pending-reboot" }
    }
  }
  db_parameter_group = {
    family               = "aurora-mysql5.7"
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

  enabled_cloudwatch_logs_exports = ["audit", "error", "general", "slowquery"]

  security_group_use_name_prefix = false

  tags = local.tags
}
