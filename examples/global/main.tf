provider "aws" {
  alias  = "virginia"
  region = "us-east-1"
}

provider "aws" {
  alias  = "ohio"
  region = "us-east-2"
}

# aws_rds_global_cluster added support for postgres in v2.57.0
terraform {
  required_providers {
    aws = ">= 2.57.0, < 4.0"
  }
}

#######################################################
# Data sources to get VPC, subnets, and encryption key
#######################################################
data "aws_vpc" "virginia" {
  default  = true
  provider = aws.virginia
}

data "aws_subnet_ids" "virginia" {
  vpc_id   = data.aws_vpc.virginia.id
  provider = aws.virginia
}

data "aws_vpc" "ohio" {
  default  = true
  provider = aws.ohio
}

data "aws_subnet_ids" "ohio" {
  vpc_id   = data.aws_vpc.ohio.id
  provider = aws.ohio
}

data "aws_kms_key" "key" {
  key_id = "alias/aws/rds"
  provider = aws.ohio
}

#####################
# RDS Aurora Cluster
#####################
module "virginia_aurora" {
  source                    = "../../"
  name                      = "aurora-example-global-virginia"
  engine                    = "aurora-postgresql"
  engine_version            = "11.7"
  engine_mode               = "provisioned"
  subnets                   = data.aws_subnet_ids.virginia.ids
  vpc_id                    = data.aws_vpc.virginia.id
  replica_count             = 2
  instance_type             = "db.r5.large"
  apply_immediately         = true
  skip_final_snapshot       = true
  create_global_cluster     = true
  global_cluster_identifier = "aurora-example-global"

  providers = {
    aws = aws.virginia
  }
}

module "ohio_aurora" {
  source                    = "../../"
  name                      = "aurora-example-global-ohio"
  engine                    = "aurora-postgresql"
  engine_version            = "11.7"
  engine_mode               = "provisioned"
  subnets                   = data.aws_subnet_ids.ohio.ids
  vpc_id                    = data.aws_vpc.ohio.id
  replica_count             = 2
  instance_type             = "db.r5.large"
  apply_immediately         = true
  skip_final_snapshot       = true

  create_global_cluster     = false
  global_cluster_identifier = "aurora-example-global"
  is_primary_region = false
  kms_key_id                    = data.aws_kms_key.key.arn
  replication_source_identifier = module.virginia_aurora.this_rds_cluster_arn
  source_region                 = "us-east-1"

  providers = {
    aws = aws.ohio
  }
}
