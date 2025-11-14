provider "aws" {
  region = local.region
}

data "aws_availability_zones" "available" {
  # Exclude local zones
  filter {
    name   = "opt-in-status"
    values = ["opt-in-not-required"]
  }
}

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
      instance_class      = "db.r8g.large"
      publicly_accessible = true
    }
    2 = {
      identifier     = "mysql-static-1"
      instance_class = "db.r8g.2xlarge"
    }
    3 = {
      identifier     = "mysql-excluded-1"
      instance_class = "db.r8g.xlarge"
      promotion_tier = 15
    }
  }

  vpc_id               = module.vpc.vpc_id
  db_subnet_group_name = module.vpc.database_subnet_group_name
  security_group_ingress_rules = {
    private-az1 = {
      cidr_ipv4 = element(module.vpc.private_subnets_cidr_blocks, 0)
    }
    private-az2 = {
      cidr_ipv4 = element(module.vpc.private_subnets_cidr_blocks, 1)
    }
    private-az3 = {
      cidr_ipv4 = element(module.vpc.private_subnets_cidr_blocks, 2)
    }
  }
  security_group_egress_rules = {
    kms-vpc-endpoint = {
      to_port                      = 443
      referenced_security_group_id = module.vpc_endpoints.security_group_id
    }
  }

  apply_immediately   = true
  skip_final_snapshot = true

  cluster_parameter_group = {
    name        = local.name
    family      = "aurora-mysql8.0"
    description = "${local.name} example cluster parameter group"
    parameters = [
      {
        name         = "connect_timeout"
        value        = 120
        apply_method = "immediate"
      },
      {
        name         = "innodb_lock_wait_timeout"
        value        = 300
        apply_method = "immediate"
      },
      {
        name         = "log_output"
        value        = "FILE"
        apply_method = "pending-reboot"
      },
      {
        name         = "max_allowed_packet"
        value        = "67108864"
        apply_method = "immediate"
      },
      {
        name         = "aurora_parallel_query"
        value        = 0
        apply_method = "pending-reboot"
      },
      {
        name         = "binlog_format"
        value        = "ROW"
        apply_method = "pending-reboot"
      },
      {
        name         = "log_bin_trust_function_creators"
        value        = 1
        apply_method = "immediate"
      },
      {
        name         = "require_secure_transport"
        value        = "ON"
        apply_method = "immediate"
      },
      {
        name         = "tls_version"
        value        = "TLSv1.2"
        apply_method = "pending-reboot"
      }
    ]
  }

  db_parameter_group = {
    name        = local.name
    family      = "aurora-mysql8.0"
    description = "${local.name} example DB parameter group"
    parameters = [
      {
        name         = "connect_timeout"
        value        = 60
        apply_method = "immediate"
      },
      {
        name         = "general_log"
        value        = 0
        apply_method = "immediate"
      },
      {
        name         = "innodb_lock_wait_timeout"
        value        = 300
        apply_method = "immediate"
      },
      {
        name         = "log_output"
        value        = "FILE"
        apply_method = "pending-reboot"
      },
      {
        name         = "long_query_time"
        value        = 5
        apply_method = "immediate"
      },
      {
        name         = "max_connections"
        value        = 2000
        apply_method = "immediate"
      },
      {
        name         = "slow_query_log"
        value        = 1
        apply_method = "immediate"
      },
      {
        name         = "log_bin_trust_function_creators"
        value        = 1
        apply_method = "immediate"
      }
    ]
  }

  enabled_cloudwatch_logs_exports = ["audit", "error", "general", "slowquery"]

  cluster_activity_stream = {
    kms_key_id = module.kms.key_id
    mode       = "async"
  }

  manage_master_user_password_rotation              = true
  master_user_password_rotation_schedule_expression = "rate(15 days)"

  tags = local.tags
}

################################################################################
# Supporting Resources
################################################################################

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 6.0"

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
  version = "~> 4.0"

  deletion_window_in_days = 7
  description             = "KMS key for ${local.name} cluster activity stream"
  enable_key_rotation     = true
  is_enabled              = true
  key_usage               = "ENCRYPT_DECRYPT"

  aliases = [local.name]

  tags = local.tags
}

# https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/DBActivityStreams.Prereqs.html#DBActivityStreams.Prereqs.KMS
module "vpc_endpoints" {
  source  = "terraform-aws-modules/vpc/aws//modules/vpc-endpoints"
  version = "~> 6.0"

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
