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
  engine          = "postgres" # This uses RDS engine, not Aurora
  engine_version  = "14.5"
  master_username = "root"

  vpc_id               = module.vpc.vpc_id
  db_subnet_group_name = module.vpc.database_subnet_group_name

  enabled_cloudwatch_logs_exports = ["postgresql"]

  # Multi-AZ
  availability_zones        = module.vpc.azs
  allocated_storage         = 256
  db_cluster_instance_class = "db.r6gd.large"
  iops                      = 2500
  storage_type              = "io1"

  skip_final_snapshot = true

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
