/**
# terraform-aws-rds-aurora

Creates a AWS Aurora RDS cluster, instances, DB subnet group and optionally:

 - RDS Enhanced Monitoring and associated required IAM role/policy
 - Cloudwatch alarms and SNS topic
 - Autoscaling for read replicas (MySQL)

### Aurora PostgreSQL

```hcl
* resource "aws_sns_topic" "db_alarms_postgres96" {
*   name = "aurora-db-alarms-postgres96"
* }

* module "aurora_db_postgres96" {
*   source                          = "path/to/module"
*   name                            = "test-aurora-db-postgres96"
*   engine                          = "aurora-postgresql"
*   engine-version                  = "9.6.3"
*   subnets                         = ["${module.vpc.database_subnets}"]
*   azs                             = ["${module.vpc.availability_zones}"]
*   vpc_id                          = "${module.vpc.vpc_id}"
*   replica_count                   = "1"
*   allowed_security_groups         = ["${aws_security_group.my_application.id}"]
*   instance_type                   = "db.r4.large"
*   storage_encrypted               = "true"
*   apply_immediately               = "true"
*   monitoring_interval             = "10"
*   cw_alarms                       = true
*   cw_sns_topic                    = "${aws_sns_topic.db_alarms_postgres96.id}"
*   db_parameter_group_name         = "${aws_db_parameter_group.aurora_db_postgres96_parameter_group.id}"
*   db_cluster_parameter_group_name = "${aws_rds_cluster_parameter_group.aurora_cluster_postgres96_parameter_group.id}"
*   tags                            = {
*     "environment" = "dev"
*     "terraform"   = "true"
*   }
* }

* resource "aws_db_parameter_group" "aurora_db_postgres96_parameter_group" {
*   name        = "test-aurora-db-postgres96-parameter-group"
*   family      = "aurora-postgresql9.6"
*   description = "test-aurora-db-postgres96-parameter-group"
* }

* resource "aws_rds_cluster_parameter_group" "aurora_cluster_postgres96_parameter_group" {
*   name        = "test-aurora-postgres96-cluster-parameter-group"
*   family      = "aurora-postgresql9.6"
*   description = "test-aurora-postgres96-cluster-parameter-group"
* }
```

### MySQL 5.6 example

```hcl
* resource "aws_sns_topic" "db_alarms_56" {
*   name = "aurora-db-alarms-56"
* }

* module "aurora_db_56" {
*   source                          = "path/to/module"
*   name                            = "test-aurora-db-56"
*   engine                          = "aurora-mysql"
*   engine-version                  = "5.6.10a"
*   subnets                         = ["${module.vpc.database_subnets}"]
*   azs                             = ["${module.vpc.availability_zones}"]
*   vpc_id                          = "${module.vpc.vpc_id}"
*   replica_count                   = "1"
*   allowed_security_groups         = ["${aws_security_group.my_application.id}"]
*   instance_type                   = "db.t2.medium"
*   cw_sns_topic                    = "${aws_sns_topic.db_alarms_56.id}"
*   db_parameter_group_name         = "${aws_db_parameter_group.aurora_db_56_parameter_group.id}"
*   db_cluster_parameter_group_name = "${aws_rds_cluster_parameter_group.aurora_cluster_56_parameter_group.id}"
* }

* resource "aws_db_parameter_group" "aurora_db_56_parameter_group" {
*   name        = "test-aurora-db-56-parameter-group"
*   family      = "aurora5.6"
*   description = "test-aurora-db-56-parameter-group"
* }

* resource "aws_rds_cluster_parameter_group" "aurora_cluster_56_parameter_group" {
*   name        = "test-aurora-56-cluster-parameter-group"
*   family      = "aurora5.6"
*   description = "test-aurora-56-cluster-parameter-group"
* }
```

### MySQL 5.7 example

```hcl
* resource "aws_sns_topic" "db_alarms" {
*   name = "aurora-db-alarms"
* }

* module "aurora_db_57" {
*   source                          = "path/to/module"
*   name                            = "test-aurora-db-57"
*   engine                          = "aurora-mysql"
*   engine-version                  = "5.7.12"
*   subnets                         = ["${module.vpc.database_subnets}"]
*   azs                             = ["${module.vpc.availability_zones}"]
*   vpc_id                          = "${module.vpc.vpc_id}"
*   replica_count                   = "1"
*   allowed_security_groups         = ["${aws_security_group.my_application.id}"]
*   instance_type                   = "db.t2.medium"
*   db_parameter_group_name         = "${aws_db_parameter_group.aurora_db_57_parameter_group.id}"
*   db_cluster_parameter_group_name = "${aws_rds_cluster_parameter_group.aurora_57_cluster_parameter_group.id}"
* }

* resource "aws_db_parameter_group" "aurora_db_57_parameter_group" {
*   name        = "test-aurora-db-57-parameter-group"
*   family      = "aurora-mysql5.7"
*   description = "test-aurora-db-57-parameter-group"
* }

* resource "aws_rds_cluster_parameter_group" "aurora_57_cluster_parameter_group" {
*   name        = "test-aurora-57-cluster-parameter-group"
*   family      = "aurora-mysql5.7"
*   description = "test-aurora-57-cluster-parameter-group"
* }
```

## Documentation generation

Documentation should be modified within `main.tf` and generated using [terraform-docs](https://github.com/segmentio/terraform-docs):

```bash
terraform-docs md ./ | cat -s | tail -r | tail -n +2 | tail -r > README.md
```

## License

MIT Licensed. See [LICENSE](https://github.com/deliveryhero/tf-ssh-bastion/tree/master/LICENSE) for full details.
*/

provider "null" {}
provider "template" {}
