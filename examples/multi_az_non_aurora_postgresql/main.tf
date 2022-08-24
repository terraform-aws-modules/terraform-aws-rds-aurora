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
# RDS Cluster Module
################################################################################

module "rds_cluster" {
  source = "../../"

  name           = local.name
  engine         = "postgres"
  engine_version = "13.4"

  allocated_storage = 100
  # Multi-AZ DB clusters only support Provisioned IOPS storage.
  storage_type              = "io1"
  iops                      = 3000
  db_cluster_instance_class = "db.m5d.large"

  vpc_id                 = module.vpc.vpc_id
  db_subnet_group_name   = module.vpc.database_subnet_group_name
  create_db_subnet_group = false
  create_security_group  = true
  allowed_cidr_blocks    = module.vpc.private_subnets_cidr_blocks

  master_password        = random_password.master.result
  create_random_password = false

  apply_immediately   = true
  skip_final_snapshot = true

  db_cluster_parameter_group_name = aws_rds_cluster_parameter_group.example.id
  enabled_cloudwatch_logs_exports = ["postgresql"]

  tags = local.tags
}

resource "aws_rds_cluster_parameter_group" "example" {
  name        = local.name
  family      = "postgres13"
  description = "${local.name}-postgres13-cluster-parameter-group"
  tags        = local.tags
}
