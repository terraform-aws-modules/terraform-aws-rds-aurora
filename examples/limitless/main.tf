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

  name           = local.name
  engine         = "aurora-postgresql"
  engine_version = "16.9-limitless"
  storage_type   = "aurora-iopt1"

  cluster_scalability_type    = "limitless"
  cluster_monitoring_interval = 30
  # https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/limitless-reqs-limits.html
  cluster_performance_insights_enabled          = true
  cluster_performance_insights_retention_period = 31

  shard_group = {
    compute_redundancy = 0
    identifier         = local.name
    max_acu            = 16
  }

  # aurora limitless clusters do not support managed master user password
  manage_master_user_password = false
  master_username             = "root"
  master_password_wo          = random_password.master.result
  master_password_wo_version  = 1

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

  apply_immediately   = true
  skip_final_snapshot = true

  cluster_parameter_group = {
    name        = local.name
    family      = "aurora-postgresql16"
    description = "${local.name} example cluster parameter group"
    parameters = [
      {
        name         = "log_min_duration_statement"
        value        = 4000
        apply_method = "immediate"
        }, {
        name         = "rds.force_ssl"
        value        = 1
        apply_method = "immediate"
      }
    ]
  }

  enabled_cloudwatch_logs_exports = ["postgresql"]
  create_cloudwatch_log_group     = true

  tags = local.tags
}

################################################################################
# Supporting Resources
################################################################################

resource "random_password" "master" {
  length  = 20
  special = false
}

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
