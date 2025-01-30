provider "aws" {
  region = local.region
}

data "aws_availability_zones" "available" {}

locals {
  name   = "ex-${basename(path.cwd)}"
  region = "eu-west-1"

  vpc_cidr = "10.0.0.0/16"
  azs      = slice(data.aws_availability_zones.available.names, 0, 3)

  tags = {
    Example    = local.name
    GithubRepo = "terraform-aws-rds-aurora"
    GithubOrg  = "terraform-aws-modules"
  }
}

################################################################################
# RDS Aurora Module
################################################################################

module "aurora" {
  source = "../../"

  name            = local.name
  engine          = "aurora-mysql"
  engine_version  = "8.0"
  master_username = "root"
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

  vpc_id               = module.vpc.vpc_id
  db_subnet_group_name = module.vpc.database_subnet_group_name
  security_group_rules = {
    vpc_ingress = {
      cidr_blocks = module.vpc.private_subnets_cidr_blocks
    }
    kms_vpc_endpoint = {
      type                     = "egress"
      from_port                = 443
      to_port                  = 443
      source_security_group_id = module.vpc_endpoints.security_group_id
    }
  }

  apply_immediately   = true
  skip_final_snapshot = true

  create_db_cluster_parameter_group      = true
  db_cluster_parameter_group_name        = local.name
  db_cluster_parameter_group_family      = "aurora-mysql8.0"
  db_cluster_parameter_group_description = "${local.name} example cluster parameter group"
  db_cluster_parameter_group_parameters = [
    {
      name         = "connect_timeout"
      value        = 120
      apply_method = "immediate"
      }, {
      name         = "innodb_lock_wait_timeout"
      value        = 300
      apply_method = "immediate"
      }, {
      name         = "log_output"
      value        = "FILE"
      apply_method = "immediate"
      }, {
      name         = "max_allowed_packet"
      value        = "67108864"
      apply_method = "immediate"
      }, {
      name         = "aurora_parallel_query"
      value        = "OFF"
      apply_method = "pending-reboot"
      }, {
      name         = "binlog_format"
      value        = "ROW"
      apply_method = "pending-reboot"
      }, {
      name         = "log_bin_trust_function_creators"
      value        = 1
      apply_method = "immediate"
      }, {
      name         = "require_secure_transport"
      value        = "ON"
      apply_method = "immediate"
      }, {
      name         = "tls_version"
      value        = "TLSv1.2"
      apply_method = "pending-reboot"
    }
  ]

  create_db_parameter_group      = true
  db_parameter_group_name        = local.name
  db_parameter_group_family      = "aurora-mysql8.0"
  db_parameter_group_description = "${local.name} example DB parameter group"
  db_parameter_group_parameters = [
    {
      name         = "connect_timeout"
      value        = 60
      apply_method = "immediate"
      }, {
      name         = "general_log"
      value        = 0
      apply_method = "immediate"
      }, {
      name         = "innodb_lock_wait_timeout"
      value        = 300
      apply_method = "immediate"
      }, {
      name         = "log_output"
      value        = "FILE"
      apply_method = "pending-reboot"
      }, {
      name         = "long_query_time"
      value        = 5
      apply_method = "immediate"
      }, {
      name         = "max_connections"
      value        = 2000
      apply_method = "immediate"
      }, {
      name         = "slow_query_log"
      value        = 1
      apply_method = "immediate"
      }, {
      name         = "log_bin_trust_function_creators"
      value        = 1
      apply_method = "immediate"
    }
  ]

  enabled_cloudwatch_logs_exports = ["audit", "error", "general", "slowquery"]

  create_db_cluster_activity_stream     = true
  db_cluster_activity_stream_kms_key_id = module.kms.key_id

  manage_master_user_password_rotation              = true
  master_user_password_rotation_schedule_expression = "rate(15 days)"

  # https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/DBActivityStreams.Overview.html#DBActivityStreams.Overview.sync-mode
  db_cluster_activity_stream_mode = "async"

  tags = local.tags
}

################################################################################
# Supporting Resources
################################################################################

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 5.0"

  name = local.name
  cidr = local.vpc_cidr

  azs              = local.azs
  public_subnets   = [for k, v in local.azs : cidrsubnet(local.vpc_cidr, 8, k)]
  private_subnets  = [for k, v in local.azs : cidrsubnet(local.vpc_cidr, 8, k + 3)]
  database_subnets = [for k, v in local.azs : cidrsubnet(local.vpc_cidr, 8, k + 6)]

  tags = local.tags
}

module "kms" {
  source  = "terraform-aws-modules/kms/aws"
  version = "~> 2.0"

  deletion_window_in_days = 7
  description             = "KMS key for ${local.name} cluster activity stream."
  enable_key_rotation     = true
  is_enabled              = true
  key_usage               = "ENCRYPT_DECRYPT"

  aliases = [local.name]

  tags = local.tags
}

# https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/DBActivityStreams.Prereqs.html#DBActivityStreams.Prereqs.KMS
module "vpc_endpoints" {
  source  = "terraform-aws-modules/vpc/aws//modules/vpc-endpoints"
  version = "~> 5.0"

  vpc_id = module.vpc.vpc_id

  create_security_group      = true
  security_group_name_prefix = "${local.name}-vpc-endpoints-"
  security_group_description = "VPC endpoint security group"
  security_group_rules = {
    ingress_https = {
      description = "HTTPS from VPC"
      cidr_blocks = [module.vpc.vpc_cidr_block]
    }
  }

  endpoints = {
    kms = {
      service             = "kms"
      private_dns_enabled = true
      subnet_ids          = module.vpc.database_subnets
    }
  }

  tags = local.tags
}
