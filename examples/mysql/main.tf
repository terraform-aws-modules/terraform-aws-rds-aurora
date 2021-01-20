provider "aws" {
  region = "us-east-1"
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

#############
# RDS Aurora
#############
module "aurora" {
  source                              = "../../"
  name                                = "aurora-example-mysql"
  engine                              = "aurora-mysql"
  engine_version                      = "5.7.12"
  subnets                             = data.aws_subnet_ids.all.ids
  vpc_id                              = data.aws_vpc.default.id
  replica_count                       = 0
  instance_type                       = "db.t2.medium"
  password                            = random_password.master.result
  create_random_password              = false
  apply_immediately                   = true
  skip_final_snapshot                 = true
  db_parameter_group_name             = aws_db_parameter_group.aurora_db_57_parameter_group.id
  db_cluster_parameter_group_name     = aws_rds_cluster_parameter_group.aurora_57_cluster_parameter_group.id
  iam_database_authentication_enabled = true
  enabled_cloudwatch_logs_exports     = ["audit", "error", "general", "slowquery"]
  allowed_cidr_blocks                 = ["10.20.0.0/20", "20.20.0.0/20"]

  create_security_group = true
}

resource "aws_db_parameter_group" "aurora_db_57_parameter_group" {
  name        = "test-aurora-db-57-parameter-group"
  family      = "aurora-mysql5.7"
  description = "test-aurora-db-57-parameter-group"
}

resource "aws_rds_cluster_parameter_group" "aurora_57_cluster_parameter_group" {
  name        = "test-aurora-57-cluster-parameter-group"
  family      = "aurora-mysql5.7"
  description = "test-aurora-57-cluster-parameter-group"
}

############################
# Example of security group
############################
resource "aws_security_group" "app_servers" {
  name_prefix = "app-servers-"
  description = "For application servers"
  vpc_id      = data.aws_vpc.default.id
}

resource "aws_security_group_rule" "allow_access" {
  type                     = "ingress"
  from_port                = module.aurora.this_rds_cluster_port
  to_port                  = module.aurora.this_rds_cluster_port
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.app_servers.id
  security_group_id        = module.aurora.this_security_group_id
}

# IAM Policy for use with iam_database_authentication_enabled = true
resource "aws_iam_policy" "aurora_mysql_policy_iam_auth" {
  name = "test-aurora-db-57-policy-iam-auth"

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "rds-db:connect"
      ],
      "Resource": [
        "arn:aws:rds-db:us-east-1:123456789012:dbuser:${module.aurora.this_rds_cluster_resource_id}/jane_doe"
      ]
    }
  ]
}
POLICY
}

resource "random_password" "master" {
  length = 10
}

module "disabled_aurora" {
  source = "../../"

  create_cluster = false
}
