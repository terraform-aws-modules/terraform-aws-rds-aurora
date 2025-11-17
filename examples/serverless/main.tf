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
# MySQL Serverless v2
################################################################################

module "aurora_mysql" {
  source = "../../"

  name              = "${local.name}-mysqlv2"
  engine            = "aurora-mysql"
  engine_mode       = "provisioned"
  engine_version    = "8.0"
  storage_encrypted = true
  master_username   = "root"

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

  cluster_monitoring_interval = 60

  apply_immediately   = true
  skip_final_snapshot = true

  serverlessv2_scaling_configuration = {
    min_capacity = 2
    max_capacity = 10
  }

  cluster_instance_class = "db.serverless"
  instances = {
    one = {}
    two = {}
  }

  tags = local.tags
}

################################################################################
# PostgreSQL Serverless v2
################################################################################

data "aws_rds_engine_version" "postgresql" {
  engine  = "aurora-postgresql"
  version = "17.5"
}

module "aurora_postgresql" {
  source = "../../"

  name              = "${local.name}-postgresqlv2"
  engine            = data.aws_rds_engine_version.postgresql.engine
  engine_mode       = "provisioned"
  engine_version    = data.aws_rds_engine_version.postgresql.version
  storage_encrypted = true
  master_username   = "root"

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

  cluster_monitoring_interval = 60

  apply_immediately   = true
  skip_final_snapshot = true

  enable_http_endpoint = true

  serverlessv2_scaling_configuration = {
    min_capacity             = 0
    max_capacity             = 10
    seconds_until_auto_pause = 3600
  }

  cluster_instance_class = "db.serverless"
  cluster_timeouts = {
    delete = "30m"
  }

  instances = {
    one = {}
    two = {}
  }
  instance_timeouts = {
    delete = "30m"
  }

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
