provider "aws" {
  region = "us-west-2"  
}

######################################
# Data sources to get VPC and subnets
######################################
data "aws_vpc" "default" {
  default = true
}

data "aws_subnet_ids" "all" {
  vpc_id = data.aws_vpc.default.id
}

##############################################
# Vars that are being used in multiple places
##############################################
locals {
  s3_import_bucket_name               = "mysql-s3-restore"
  s3_import_bucket_prefix             = "percona-backup/"
}


#############
# RDS Aurora
#############

module "aurora" {
  source                              = "../../"
  name                                = "aurora-example-mysql"
  engine                              = "aurora"
  engine_version                      = "5.6.mysql_aurora.1.22.2"
  subnets                             = data.aws_subnet_ids.all.ids
  vpc_id                              = data.aws_vpc.default.id
  replica_count                       = 1
  instance_type                       = "db.t2.medium"
  apply_immediately                   = true
  skip_final_snapshot                 = true
  iam_database_authentication_enabled = true
  enabled_cloudwatch_logs_exports     = ["audit", "error", "general", "slowquery"]
  allowed_cidr_blocks                 = ["10.20.0.0/20", "20.20.0.0/20"]
  password                            = "Password123"

  # Assumes that the bucket already exists and the backup already resides in the s3 bucket
  s3_import_bucket_name               = local.s3_import_bucket_name
  s3_import_bucket_prefix             = local.s3_import_bucket_prefix
  # The following condition allows the module to have a dependency on the policy attachment
  s3_import_ingestion_role            = aws_iam_role_policy_attachment.s3_import_role_policy_attachment.role != "" ? aws_iam_role.aurora_mysql_policy_iam_auth.arn : ""
  s3_import_source_engine             = "mysql"
  s3_import_source_engine_version     = "5.6.41"
  
  tags                                = {
    Environment = "dev"
    Terraform   = "true"
    }
}


##################################
# IAM Policy & Role for S3 Import
##################################

resource "aws_iam_policy" "s3_rds_import_policy" {
    name = "s3_import_rds_tf_policy"
    path = "/"
    description = "Policy used to grant required access for RDS to import your backup from S3"
    policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "s3:ListBucket",
                "s3:GetBucketLocation"
            ],
            "Resource": [
                "arn:aws:s3:::${local.s3_import_bucket_name}"
            ]
        },
        {
            "Effect": "Allow",
            "Action": [
                "s3:GetObject"
            ],
            "Resource": [
                "arn:aws:s3:::${local.s3_import_bucket_name}/${local.s3_import_bucket_prefix}*"
            ]
        }
    ]
}
EOF
}


resource "aws_iam_role" "aurora_mysql_policy_iam_auth" {
  name = "test-aurora-db-s3-import-policy-iam-auth"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": {
    "Effect": "Allow",
    "Principal": {"Service": "rds.amazonaws.com"},
    "Action": "sts:AssumeRole"
  }
}
  EOF

  tags = {
    Environment = "dev"
    Terraform   = "true"
    }
}

resource "aws_iam_role_policy_attachment" "s3_import_role_policy_attachment" {
    role = aws_iam_role.aurora_mysql_policy_iam_auth.name
    policy_arn = aws_iam_policy.s3_rds_import_policy.arn
}