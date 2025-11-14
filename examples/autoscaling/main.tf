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

  name                   = local.name
  engine                 = "aurora-postgresql"
  engine_version         = "17.5"
  cluster_instance_class = "db.r8g.large"
  instances              = { 1 = {} }
  master_username        = "root"

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

  autoscaling_enabled      = true
  autoscaling_min_capacity = 1
  autoscaling_max_capacity = 5

  cluster_monitoring_interval   = 60
  iam_role_name                 = "${local.name}-monitor"
  iam_role_use_name_prefix      = true
  iam_role_description          = "${local.name} RDS enhanced monitoring IAM role"
  iam_role_path                 = "/autoscaling/"
  iam_role_max_session_duration = 7200

  apply_immediately   = true
  skip_final_snapshot = true

  enabled_cloudwatch_logs_exports = ["postgresql"]

  tags = local.tags
}

module "disabled_aurora" {
  source = "../../"

  create = false
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
