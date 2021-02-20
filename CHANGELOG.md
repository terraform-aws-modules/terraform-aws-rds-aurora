# Change Log

All notable changes to this project will be documented in this file.

<a name="unreleased"></a>
## [Unreleased]



<a name="v3.6.0"></a>
## [v3.6.0] - 2021-02-20

- chore: update documentation based on latest `terraform-docs` which includes module and resource sections ([#191](https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/issues/191))


<a name="v3.5.0"></a>
## [v3.5.0] - 2021-02-14

- feat: Support major version engine upgrades ([#188](https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/issues/188))


<a name="v3.4.0"></a>
## [v3.4.0] - 2021-01-20

- fix: Create random_password conditionally ([#184](https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/issues/184))


<a name="v3.3.0"></a>
## [v3.3.0] - 2021-01-15

- docs: Update Serverless MySQL/PostgreSQL example ([#95](https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/issues/95))


<a name="v3.2.0"></a>
## [v3.2.0] - 2021-01-15

- fix: Added possibility to specify partition used in iam role policy attachment ([#182](https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/issues/182))


<a name="v3.1.0"></a>
## [v3.1.0] - 2021-01-15

- fix: Create random_password only when necessary ([#181](https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/issues/181))


<a name="v3.0.0"></a>
## [v3.0.0] - 2021-01-04

- feat: Added conditional creation of RDS Aurora cluster ([#180](https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/issues/180))


<a name="v2.29.0"></a>
## [v2.29.0] - 2020-10-30

- feat: Added conditional creation of RDS Aurora cluster ([#159](https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/issues/159))


<a name="v2.28.0"></a>
## [v2.28.0] - 2020-10-13

- Updated docs
- feat: add output engine_version to force provider order ([#152](https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/issues/152))


<a name="v2.27.0"></a>
## [v2.27.0] - 2020-10-07

- feat: Updated pre-commit with tflint ([#150](https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/issues/150))
- fix: Ignore instance engine version updates ([#134](https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/issues/134))


<a name="v2.26.0"></a>
## [v2.26.0] - 2020-09-22

- feat: Allow to customizable instance settings ([#146](https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/issues/146))


<a name="v2.25.0"></a>
## [v2.25.0] - 2020-09-22



<a name="v2.24.0"></a>
## [v2.24.0] - 2020-09-22

- feat: Add support for existing IAM role for enhanced monitoring ([#79](https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/issues/79))


<a name="v2.23.0"></a>
## [v2.23.0] - 2020-08-27

- feat: Allows different instance_size for replicas ([#61](https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/issues/61))


<a name="v2.22.0"></a>
## [v2.22.0] - 2020-08-19

- feat: Add output aws_rds_cluster.this.hosted_zone_id ([#125](https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/issues/125))


<a name="v2.21.0"></a>
## [v2.21.0] - 2020-08-13

- Updated version requirements for AWS provider v3


<a name="v2.20.0"></a>
## [v2.20.0] - 2020-07-20

- feat: Add tags to RDS enhanced monitoring IAM role ([#136](https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/issues/136))
- Upgraded Terraform version supported


<a name="v2.19.0"></a>
## [v2.19.0] - 2020-06-12

- feat: add "this_rds_cluster_instance_ids" to module outputs ([#107](https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/issues/107))
- docs: Add "multimaster" to engine_mode docs ([#133](https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/issues/133))


<a name="v2.18.0"></a>
## [v2.18.0] - 2020-06-10

- feat: Add permissions boundary for IAM role ([#104](https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/issues/104))
- Updated README


<a name="v2.17.0"></a>
## [v2.17.0] - 2020-04-11

- feat: Support enable_http_endpoint - Data API ([#117](https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/issues/117))
- Updated postgres example to latest engine_version


<a name="v2.16.0"></a>
## [v2.16.0] - 2020-02-26

- Updated pre-commit-terraform with README
- Updated pre-commit-terraform with README
- Adding support for ca_cert_identifier for the upcoming RDS cert update on 5 March 2020 ([#91](https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/issues/91)) ([#98](https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/issues/98))
- Added missing type type for allowed_security_groups variable ([#97](https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/issues/97))


<a name="v2.15.0"></a>
## [v2.15.0] - 2020-01-28

- Disabled special characters in random_password ([#101](https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/issues/101))


<a name="v2.14.0"></a>
## [v2.14.0] - 2020-01-23

- Changed random_id to random_password resource ([#99](https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/issues/99))


<a name="v2.13.0"></a>
## [v2.13.0] - 2020-01-23

- Adding version requirements


<a name="v2.12.0"></a>
## [v2.12.0] - 2020-01-23

- Updated pre-commit-terraform to support terraform-docs 0.8
- Hide sensitive password data from cli output ([#89](https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/issues/89))


<a name="v2.11.0"></a>
## [v2.11.0] - 2019-11-29

- Made description of security group backward compatible (and optional) ([#87](https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/issues/87))
- Add security group name and description ([#80](https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/issues/80))
- Updated README
- Set null as default db_parameter_group_name ([#72](https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/issues/72))
- Support setting aws_rds_cluster iam roles ([#74](https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/issues/74))
- Fix the error when "create_security_group" is false ([#75](https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/issues/75))
- Added support for conditional creation of SG and allowed CIDR blocks ([#71](https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/issues/71))
- Updated README
- Add option to customise predefined_metric_type ([#66](https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/issues/66))
- Added support for backtrack_window, cross region read replicas, copy_tags_to_snapshots, scaling_configurations ([#70](https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/issues/70))
- Fixes after [#64](https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/issues/64) (subnets are optional now), updated pre-commit hooks and docs
- Add support to use existing subnet group name ([#64](https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/issues/64))
- Fix PostgreSQL example link ([#52](https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/issues/52))
- Support using previously created SG for Aurora cluster - TF 0.12 ([#49](https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/issues/49))
- Add cluster ARN output as 'this_rds_cluster_arn' ([#48](https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/issues/48))
- Upgraded module to support Terraform 0.12 ([#45](https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/issues/45))

### 

on ../../modules/aws-rds-aurora/main.tf line 4, in locals:

4:   db_subnet_group_name = var.db_subnet_group_name == "" ?
aws_db_subnet_group.this[0].name : var.db_subnet_group_name

|----------------

| aws_db_subnet_group.this is empty tuple

when calling import with this module in the configuration.


<a name="v1.21.0"></a>
## [v1.21.0] - 2019-11-28

- Revert "add support for ca_cert_identifier option ([#83](https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/issues/83))" ([#85](https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/issues/85))
- add support for ca_cert_identifier option ([#83](https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/issues/83))
- Updated docs
- Add scaling_configuration ([#63](https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/issues/63))
- Added ability to deploy a cross region Aurora Cluster Read Replica ([#69](https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/issues/69))
- Added backtrack_windows for Aurora ([#57](https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/issues/57))
- Added changelog
- Added copy_tags_to_snapshot (closes [#60](https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/issues/60))
- Allow the addition of IP-based ingress rules ([#51](https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/issues/51))
- vpc_security_group_ids for Terraform 0.11 ([#46](https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/issues/46))


<a name="v2.10.0"></a>
## [v2.10.0] - 2019-11-28

- Add security group name and description ([#80](https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/issues/80))
- Updated README
- Set null as default db_parameter_group_name ([#72](https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/issues/72))
- Support setting aws_rds_cluster iam roles ([#74](https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/issues/74))
- Fix the error when "create_security_group" is false ([#75](https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/issues/75))
- Added support for conditional creation of SG and allowed CIDR blocks ([#71](https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/issues/71))
- Updated README
- Add option to customise predefined_metric_type ([#66](https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/issues/66))
- Added support for backtrack_window, cross region read replicas, copy_tags_to_snapshots, scaling_configurations ([#70](https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/issues/70))
- Fixes after [#64](https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/issues/64) (subnets are optional now), updated pre-commit hooks and docs
- Add support to use existing subnet group name ([#64](https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/issues/64))
- Fix PostgreSQL example link ([#52](https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/issues/52))
- Support using previously created SG for Aurora cluster - TF 0.12 ([#49](https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/issues/49))
- Add cluster ARN output as 'this_rds_cluster_arn' ([#48](https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/issues/48))
- Upgraded module to support Terraform 0.12 ([#45](https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/issues/45))

### 

on ../../modules/aws-rds-aurora/main.tf line 4, in locals:

4:   db_subnet_group_name = var.db_subnet_group_name == "" ?
aws_db_subnet_group.this[0].name : var.db_subnet_group_name

|----------------

| aws_db_subnet_group.this is empty tuple

when calling import with this module in the configuration.


<a name="v1.20.0"></a>
## [v1.20.0] - 2019-11-28

- add support for ca_cert_identifier option ([#83](https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/issues/83))
- Updated docs
- Add scaling_configuration ([#63](https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/issues/63))
- Added ability to deploy a cross region Aurora Cluster Read Replica ([#69](https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/issues/69))
- Added backtrack_windows for Aurora ([#57](https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/issues/57))
- Added changelog
- Added copy_tags_to_snapshot (closes [#60](https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/issues/60))
- Allow the addition of IP-based ingress rules ([#51](https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/issues/51))
- vpc_security_group_ids for Terraform 0.11 ([#46](https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/issues/46))


<a name="v2.9.0"></a>
## [v2.9.0] - 2019-11-08

- Updated README
- Set null as default db_parameter_group_name ([#72](https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/issues/72))


<a name="v2.8.0"></a>
## [v2.8.0] - 2019-11-08

- Support setting aws_rds_cluster iam roles ([#74](https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/issues/74))


<a name="v2.7.0"></a>
## [v2.7.0] - 2019-11-08

- Fix the error when "create_security_group" is false ([#75](https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/issues/75))


<a name="v2.6.0"></a>
## [v2.6.0] - 2019-09-30

- Added support for conditional creation of SG and allowed CIDR blocks ([#71](https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/issues/71))


<a name="v2.5.0"></a>
## [v2.5.0] - 2019-09-30

- Updated README
- Add option to customise predefined_metric_type ([#66](https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/issues/66))


<a name="v2.4.0"></a>
## [v2.4.0] - 2019-09-30

- Added support for backtrack_window, cross region read replicas, copy_tags_to_snapshots, scaling_configurations ([#70](https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/issues/70))
- Fixes after [#64](https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/issues/64) (subnets are optional now), updated pre-commit hooks and docs
- Add support to use existing subnet group name ([#64](https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/issues/64))
- Fix PostgreSQL example link ([#52](https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/issues/52))
- Support using previously created SG for Aurora cluster - TF 0.12 ([#49](https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/issues/49))
- Add cluster ARN output as 'this_rds_cluster_arn' ([#48](https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/issues/48))
- Upgraded module to support Terraform 0.12 ([#45](https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/issues/45))


<a name="v1.19.0"></a>
## [v1.19.0] - 2019-09-29

- Updated docs
- Add scaling_configuration ([#63](https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/issues/63))


<a name="v1.18.0"></a>
## [v1.18.0] - 2019-09-29

- Added ability to deploy a cross region Aurora Cluster Read Replica ([#69](https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/issues/69))


<a name="v1.17.0"></a>
## [v1.17.0] - 2019-09-28

- Added backtrack_windows for Aurora ([#57](https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/issues/57))


<a name="v1.16.0"></a>
## [v1.16.0] - 2019-09-28

- Added changelog
- Added copy_tags_to_snapshot (closes [#60](https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/issues/60))
- Allow the addition of IP-based ingress rules ([#51](https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/issues/51))
- vpc_security_group_ids for Terraform 0.11 ([#46](https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/issues/46))


<a name="v2.3.0"></a>
## [v2.3.0] - 2019-08-29

- Fixes after [#64](https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/issues/64) (subnets are optional now), updated pre-commit hooks and docs
- Add support to use existing subnet group name ([#64](https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/issues/64))
- Fix PostgreSQL example link ([#52](https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/issues/52))


<a name="v2.2.0"></a>
## [v2.2.0] - 2019-06-24

- Support using previously created SG for Aurora cluster - TF 0.12 ([#49](https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/issues/49))
- Add cluster ARN output as 'this_rds_cluster_arn' ([#48](https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/issues/48))
- Upgraded module to support Terraform 0.12 ([#45](https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/issues/45))


<a name="v1.15.0"></a>
## [v1.15.0] - 2019-06-24

- Allow the addition of IP-based ingress rules ([#51](https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/issues/51))
- vpc_security_group_ids for Terraform 0.11 ([#46](https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/issues/46))


<a name="v2.1.0"></a>
## [v2.1.0] - 2019-06-14

- Add cluster ARN output as 'this_rds_cluster_arn' ([#48](https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/issues/48))
- Upgraded module to support Terraform 0.12 ([#45](https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/issues/45))


<a name="v1.14.0"></a>
## [v1.14.0] - 2019-06-13

- vpc_security_group_ids for Terraform 0.11 ([#46](https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/issues/46))


<a name="v2.0.0"></a>
## [v2.0.0] - 2019-06-11

- Upgraded module to support Terraform 0.12 ([#45](https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/issues/45))


<a name="v1.13.0"></a>
## [v1.13.0] - 2019-04-25

- Fixed formatting
- Remove unused variable identifier_prefix ([#36](https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/issues/36))
- Correct description of replica_scale_min variable ([#37](https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/issues/37))


<a name="v1.12.0"></a>
## [v1.12.0] - 2019-03-22

- Fix formatting
- Feature/rds cluster resource id output ([#31](https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/issues/31))


<a name="v1.11.0"></a>
## [v1.11.0] - 2019-03-22

- Fix formatting and string variables
- add engine_mode and global_cluster_identifier ([#32](https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/issues/32))


<a name="v1.10.0"></a>
## [v1.10.0] - 2019-02-28

- Fixed readme
- add enabled_cloudwatch_logs_exports ([#29](https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/issues/29))


<a name="v1.9.0"></a>
## [v1.9.0] - 2019-02-16

- Remove validation
- Add support for IAM Database authentication


<a name="v1.8.0"></a>
## [v1.8.0] - 2019-01-31

- Updated example with correct allowed_security_groups_count
- Run pre-commit hooks
- Hardcode number of allowed_security_groups


<a name="v1.7.0"></a>
## [v1.7.0] - 2019-01-30

- Removing myself from README


<a name="v1.6.0"></a>
## [v1.6.0] - 2019-01-30

- Merge remote-tracking branch 'origin/master' into pr-13
- Added output for database_name
- add support for database_name argument


<a name="v1.5.0"></a>
## [v1.5.0] - 2019-01-30

- Merge branch 'master' into support_deletion_protection
- Added argument deletion_protection


<a name="v1.4.0"></a>
## [v1.4.0] - 2019-01-30

- Removed availability_zones var (closes [#10](https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/issues/10))


<a name="v1.3.0"></a>
## [v1.3.0] - 2019-01-30

- Run pre-commit hooks
- Merge branch 'master' into fix_az
- Fixed variable for az


<a name="v1.1.0"></a>
## [v1.1.0] - 2019-01-30

- Run pre-commit hooks
- 3 adjustments: - Avoid description attr on aws_security_group to avoid forcing new instance on changes - Use name-prefix to ensure unique names - Avoid unnecessary name-prefixes


<a name="v1.0.0"></a>
## [v1.0.0] - 2018-12-11

- Updated pre-commit hooks version
- Fix for: 'count' cannot be computed
- Added few files
- Made small changes to be closer to other terraform-aws-modules
- adding pre commit hooks config
- updating readme, docs, main.tf etc
- adding port output
- adding 3 examples
- Removing route53 record and all monitoring as requested
- many fixes and changes
- Initial commit


<a name="v0.0.1"></a>
## v0.0.1 - 2017-09-26

- Initial commit
- Initial commit


[Unreleased]: https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/compare/v3.6.0...HEAD
[v3.6.0]: https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/compare/v3.5.0...v3.6.0
[v3.5.0]: https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/compare/v3.4.0...v3.5.0
[v3.4.0]: https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/compare/v3.3.0...v3.4.0
[v3.3.0]: https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/compare/v3.2.0...v3.3.0
[v3.2.0]: https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/compare/v3.1.0...v3.2.0
[v3.1.0]: https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/compare/v3.0.0...v3.1.0
[v3.0.0]: https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/compare/v2.29.0...v3.0.0
[v2.29.0]: https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/compare/v2.28.0...v2.29.0
[v2.28.0]: https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/compare/v2.27.0...v2.28.0
[v2.27.0]: https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/compare/v2.26.0...v2.27.0
[v2.26.0]: https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/compare/v2.25.0...v2.26.0
[v2.25.0]: https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/compare/v2.24.0...v2.25.0
[v2.24.0]: https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/compare/v2.23.0...v2.24.0
[v2.23.0]: https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/compare/v2.22.0...v2.23.0
[v2.22.0]: https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/compare/v2.21.0...v2.22.0
[v2.21.0]: https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/compare/v2.20.0...v2.21.0
[v2.20.0]: https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/compare/v2.19.0...v2.20.0
[v2.19.0]: https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/compare/v2.18.0...v2.19.0
[v2.18.0]: https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/compare/v2.17.0...v2.18.0
[v2.17.0]: https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/compare/v2.16.0...v2.17.0
[v2.16.0]: https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/compare/v2.15.0...v2.16.0
[v2.15.0]: https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/compare/v2.14.0...v2.15.0
[v2.14.0]: https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/compare/v2.13.0...v2.14.0
[v2.13.0]: https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/compare/v2.12.0...v2.13.0
[v2.12.0]: https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/compare/v2.11.0...v2.12.0
[v2.11.0]: https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/compare/v1.21.0...v2.11.0
[v1.21.0]: https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/compare/v2.10.0...v1.21.0
[v2.10.0]: https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/compare/v1.20.0...v2.10.0
[v1.20.0]: https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/compare/v2.9.0...v1.20.0
[v2.9.0]: https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/compare/v2.8.0...v2.9.0
[v2.8.0]: https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/compare/v2.7.0...v2.8.0
[v2.7.0]: https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/compare/v2.6.0...v2.7.0
[v2.6.0]: https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/compare/v2.5.0...v2.6.0
[v2.5.0]: https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/compare/v2.4.0...v2.5.0
[v2.4.0]: https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/compare/v1.19.0...v2.4.0
[v1.19.0]: https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/compare/v1.18.0...v1.19.0
[v1.18.0]: https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/compare/v1.17.0...v1.18.0
[v1.17.0]: https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/compare/v1.16.0...v1.17.0
[v1.16.0]: https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/compare/v2.3.0...v1.16.0
[v2.3.0]: https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/compare/v2.2.0...v2.3.0
[v2.2.0]: https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/compare/v1.15.0...v2.2.0
[v1.15.0]: https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/compare/v2.1.0...v1.15.0
[v2.1.0]: https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/compare/v1.14.0...v2.1.0
[v1.14.0]: https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/compare/v2.0.0...v1.14.0
[v2.0.0]: https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/compare/v1.13.0...v2.0.0
[v1.13.0]: https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/compare/v1.12.0...v1.13.0
[v1.12.0]: https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/compare/v1.11.0...v1.12.0
[v1.11.0]: https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/compare/v1.10.0...v1.11.0
[v1.10.0]: https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/compare/v1.9.0...v1.10.0
[v1.9.0]: https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/compare/v1.8.0...v1.9.0
[v1.8.0]: https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/compare/v1.7.0...v1.8.0
[v1.7.0]: https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/compare/v1.6.0...v1.7.0
[v1.6.0]: https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/compare/v1.5.0...v1.6.0
[v1.5.0]: https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/compare/v1.4.0...v1.5.0
[v1.4.0]: https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/compare/v1.3.0...v1.4.0
[v1.3.0]: https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/compare/v1.1.0...v1.3.0
[v1.1.0]: https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/compare/v1.0.0...v1.1.0
[v1.0.0]: https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/compare/v0.0.1...v1.0.0
