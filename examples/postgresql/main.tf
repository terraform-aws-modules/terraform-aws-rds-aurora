provider "aws" {
  region = local.region
}

locals {
  name   = "postgresql"
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

  name                  = local.name
  engine                = "aurora-postgresql"
  engine_version        = "11.9"
  instance_type         = "db.r5.large"
  instance_type_replica = "db.t3.medium"

  vpc_id                = module.vpc.vpc_id
  db_subnet_group_name  = module.vpc.database_subnet_group_name
  create_security_group = true
  allowed_cidr_blocks   = module.vpc.private_subnets_cidr_blocks

  replica_count                       = 2
  iam_database_authentication_enabled = true
  password                            = random_password.master.result
  create_random_password              = false

  apply_immediately   = true
  skip_final_snapshot = true

  db_parameter_group_name         = aws_db_parameter_group.example.id
  db_cluster_parameter_group_name = aws_rds_cluster_parameter_group.example.id
  enabled_cloudwatch_logs_exports = ["postgresql"]

  tags = local.tags
}

resource "aws_db_parameter_group" "example" {
  name        = "${local.name}-aurora-db-postgres11-parameter-group"
  family      = "aurora-postgresql11"
  description = "${local.name}-aurora-db-postgres11-parameter-group"
  tags        = local.tags
}

resource "aws_rds_cluster_parameter_group" "example" {
  name        = "${local.name}-aurora-postgres11-cluster-parameter-group"
  family      = "aurora-postgresql11"
  description = "${local.name}-aurora-postgres11-cluster-parameter-group"
  tags        = local.tags
}
