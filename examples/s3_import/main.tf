provider "aws" {
  region = local.region
}

locals {
  name   = "s3-import"
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

resource "random_pet" "this" {
  length = 2
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

  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = local.tags
}

module "import_s3_bucket" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "~> 2.0"

  bucket        = "${local.name}-${random_pet.this.id}"
  acl           = "private"
  force_destroy = true

  tags = local.tags
}

data "aws_iam_policy_document" "s3_import_assume" {
  statement {
    actions = [
      "sts:AssumeRole",
    ]

    principals {
      type        = "Service"
      identifiers = ["rds.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "s3_import" {
  name                  = "${local.name}-${random_pet.this.id}"
  description           = "IAM role to allow RDS to import MySQL backup from S3"
  assume_role_policy    = data.aws_iam_policy_document.s3_import_assume.json
  force_detach_policies = true

  tags = local.tags
}

data "aws_iam_policy_document" "s3_import" {
  statement {
    actions = [
      "s3:ListBucket",
      "s3:GetBucketLocation",
    ]

    resources = [
      module.import_s3_bucket.s3_bucket_arn
    ]
  }

  statement {
    actions = [
      "s3:GetObject",
    ]

    resources = [
      "${module.import_s3_bucket.s3_bucket_arn}/*",
    ]
  }
}

resource "aws_iam_role_policy" "s3_import" {
  name   = "${local.name}-${random_pet.this.id}"
  role   = aws_iam_role.s3_import.id
  policy = data.aws_iam_policy_document.s3_import.json

  # We need the files uploaded before the RDS instance is created, and the instance
  # also needs this role so this is an easy way of ensuring the backup is uploaded before
  # the instance creation starts
  provisioner "local-exec" {
    command = "unzip backup.zip && aws s3 sync ${path.module}/backup s3://${module.import_s3_bucket.s3_bucket_id}"
  }
}

################################################################################
# RDS Aurora Module
################################################################################

module "aurora" {
  source = "../../"

  name           = local.name
  engine         = "aurora-mysql"
  engine_version = "5.7.12"
  instance_type  = "db.r5.large"

  vpc_id                = module.vpc.vpc_id
  db_subnet_group_name  = module.vpc.database_subnet_group_name
  create_security_group = true
  allowed_cidr_blocks   = module.vpc.private_subnets_cidr_blocks

  replica_count                       = 1
  iam_database_authentication_enabled = true
  password                            = random_password.master.result
  create_random_password              = false

  # S3 import https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/AuroraMySQL.Integrating.LoadFromS3.html
  s3_import = {
    source_engine_version = "5.7.12"
    bucket_name           = module.import_s3_bucket.s3_bucket_id
    ingestion_role        = aws_iam_role.s3_import.arn
  }

  apply_immediately   = true
  skip_final_snapshot = true

  db_parameter_group_name         = aws_db_parameter_group.example.id
  db_cluster_parameter_group_name = aws_rds_cluster_parameter_group.example.id
  enabled_cloudwatch_logs_exports = ["audit", "error", "general", "slowquery"]

  tags = local.tags
}

resource "aws_db_parameter_group" "example" {
  name        = "${local.name}-aurora-db-57-parameter-group"
  family      = "aurora-mysql5.7"
  description = "${local.name}-aurora-db-57-parameter-group"
  tags        = local.tags
}

resource "aws_rds_cluster_parameter_group" "example" {
  name        = "${local.name}-aurora-57-cluster-parameter-group"
  family      = "aurora-mysql5.7"
  description = "${local.name}-aurora-57-cluster-parameter-group"
  tags        = local.tags
}
