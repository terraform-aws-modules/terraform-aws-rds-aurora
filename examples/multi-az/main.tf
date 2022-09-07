provider "aws" {
  region = local.region
}

locals {
  name   = "ex-${replace(basename(path.cwd), "_", "-")}"
  region = "eu-west-1"

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
  engine         = "postgres" # This uses RDS, not Aurora
  engine_version = "13.7"

  vpc_id  = module.vpc.vpc_id
  subnets = module.vpc.private_subnets

  create_db_cluster_parameter_group = true
  db_cluster_parameter_group_family = "postgres13"
  enabled_cloudwatch_logs_exports   = ["postgresql"]

  # Multi-AZ
  availability_zones        = module.vpc.azs
  allocated_storage         = 256
  db_cluster_instance_class = "db.r6gd.large"
  iops                      = 2500
  storage_type              = "io1"

  tags = local.tags
}

################################################################################
# Supporting Resources
################################################################################

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

  create_database_subnet_group = false
  enable_nat_gateway           = false # Disabled NAT to be able to run this example quicker

  tags = local.tags
}
