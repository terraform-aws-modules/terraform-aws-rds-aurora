# Change Log

All notable changes to this project will be documented in this file.

<a name="unreleased"></a>
## [Unreleased]



<a name="v5.2.0"></a>
## [v5.2.0] - 2021-04-30

- fix: Don't use instance_type_replica for main replica ([#211](https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/issues/211))


<a name="v5.1.0"></a>
## [v5.1.0] - 2021-04-30

- chore: add output for cluster instance `db_resource_id` output list ([#218](https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/issues/218))


<a name="v5.0.0"></a>
## [v5.0.0] - 2021-04-26

- feat: Shorten outputs (removing this_) ([#216](https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/issues/216))


<a name="v4.3.0"></a>
## [v4.3.0] - 2021-04-24

- fix: mark sensitive outputs to support Terraform 0.15.x ([#215](https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/issues/215))


<a name="v4.2.0"></a>
## [v4.2.0] - 2021-04-21

- fix: set backup and maintenance windows to `null` when using serverless mode ([#213](https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/issues/213))


<a name="v4.1.0"></a>
## [v4.1.0] - 2021-04-13

- docs: Clarify description of skip_final_snapshot variable ([#209](https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/issues/209))
- chore: update documentation and pin `terraform_docs` version to avoid future changes ([#207](https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/issues/207))


<a name="v4.0.0"></a>
## [v4.0.0] - 2021-03-25

- feat: Simplify instrance_parameters (Terraform 0.13) ([#206](https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/issues/206))


<a name="v3.13.0"></a>
## [v3.13.0] - 2021-03-21

- feat: Additional tags for security group ([#205](https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/issues/205))


<a name="v3.12.0"></a>
## [v3.12.0] - 2021-03-19

- fix: when `engine_mode` is `serverless`, set `engine_version` to `null` ([#204](https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/issues/204))


<a name="v3.11.0"></a>
## [v3.11.0] - 2021-03-18

- fix: Bump AWS provider version ([#202](https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/issues/202))


<a name="v3.10.0"></a>
## [v3.10.0] - 2021-03-14

- chore: add all attributes and some outputs for enhanced monitoring IAM role ([#201](https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/issues/201))


<a name="v3.9.0"></a>
## [v3.9.0] - 2021-03-13

- chore: update examples to to be self-sufficient and using latest practices/versions ([#200](https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/issues/200))
- chore: update README documentation and reference to license ([#199](https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/issues/199))


<a name="v3.8.0"></a>
## [v3.8.0] - 2021-03-08

- feat: AWS Instance Scheduler Tagging Support ([#198](https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/issues/198))


<a name="v3.7.0"></a>
## [v3.7.0] - 2021-03-02

- feat: add S3 import functionality which is supported for MySQL instances ([#197](https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/issues/197))
- chore: add ci-cd workflow for pre-commit checks ([#195](https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/issues/195))


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
- Merge pull request [#116](https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/issues/116) from terraform-aws-modules/terraform-provider-githubfile-1584635292483240000
- [ci skip] Create ".chglog/CHANGELOG.tpl.md".
- Merge pull request [#114](https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/issues/114) from terraform-aws-modules/terraform-provider-githubfile-1584537210006480000
- [ci skip] Create "Makefile".
- Merge pull request [#110](https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/issues/110) from terraform-aws-modules/terraform-provider-githubfile-1584537179488954000
- Merge pull request [#111](https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/issues/111) from terraform-aws-modules/terraform-provider-githubfile-1584537179489000000
- Merge pull request [#112](https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/issues/112) from terraform-aws-modules/terraform-provider-githubfile-1584537179488978000
- Merge pull request [#109](https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/issues/109) from terraform-aws-modules/terraform-provider-githubfile-1584537179488979000
- [ci skip] Create "LICENSE".
- [ci skip] Create ".gitignore".
- [ci skip] Create ".pre-commit-config.yaml".
- [ci skip] Create ".editorconfig".
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

- Merge pull request [#25](https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/issues/25) from Blokje5/add-support-for-database-iam-authentication
- Remove validation
- Add support for IAM Database authentication


<a name="v1.8.0"></a>
## [v1.8.0] - 2019-01-31

- Updated example with correct allowed_security_groups_count
- Run pre-commit hooks
- Merge pull request [#23](https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/issues/23) from dekimsey/fix-default-ingress-count-error
- Hardcode number of allowed_security_groups


<a name="v1.7.0"></a>
## [v1.7.0] - 2019-01-30

- Merge pull request [#21](https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/issues/21) from max-rocket-internet/remove_maintainer
- Removing myself from README


<a name="v1.6.0"></a>
## [v1.6.0] - 2019-01-30

- Merge pull request [#22](https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/issues/22) from terraform-aws-modules/pr/13
- Merge remote-tracking branch 'origin/master' into pr-13
- Added output for database_name
- add support for database_name argument


<a name="v1.5.0"></a>
## [v1.5.0] - 2019-01-30

- Merge pull request [#15](https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/issues/15) from christiangjengedal/support_deletion_protection
- Merge branch 'master' into support_deletion_protection
- Added argument deletion_protection


<a name="v1.4.0"></a>
## [v1.4.0] - 2019-01-30

- Merge pull request [#20](https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/issues/20) from terraform-aws-modules/removed_azs
- Removed availability_zones var (closes [#10](https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/issues/10))


<a name="v1.3.0"></a>
## [v1.3.0] - 2019-01-30

- Run pre-commit hooks
- Merge pull request [#16](https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/issues/16) from terraform-aws-modules/fix_az
- Merge branch 'master' into fix_az
- Fixed variable for az


<a name="v1.1.0"></a>
## [v1.1.0] - 2019-01-30

- Run pre-commit hooks
- Merge pull request [#17](https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/issues/17) from christiangjengedal/mod_securitygroup
- 3 adjustments: - Avoid description attr on aws_security_group to avoid forcing new instance on changes - Use name-prefix to ensure unique names - Avoid unnecessary name-prefixes


<a name="v1.0.0"></a>
## [v1.0.0] - 2018-12-11

- Updated pre-commit hooks version
- Merge pull request [#4](https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/issues/4) from FutureSharks/example_fix
- Merge pull request [#3](https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/issues/3) from terraform-aws-modules/post_initial_commit
- Fix for: 'count' cannot be computed
- Added few files
- Made small changes to be closer to other terraform-aws-modules
- Merge pull request [#1](https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/issues/1) from FutureSharks/initial_commit
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


[Unreleased]: https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/compare/v5.2.0...HEAD
[v5.2.0]: https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/compare/v5.1.0...v5.2.0
[v5.1.0]: https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/compare/v5.0.0...v5.1.0
[v5.0.0]: https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/compare/v4.3.0...v5.0.0
[v4.3.0]: https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/compare/v4.2.0...v4.3.0
[v4.2.0]: https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/compare/v4.1.0...v4.2.0
[v4.1.0]: https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/compare/v4.0.0...v4.1.0
[v4.0.0]: https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/compare/v3.13.0...v4.0.0
[v3.13.0]: https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/compare/v3.12.0...v3.13.0
[v3.12.0]: https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/compare/v3.11.0...v3.12.0
[v3.11.0]: https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/compare/v3.10.0...v3.11.0
[v3.10.0]: https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/compare/v3.9.0...v3.10.0
[v3.9.0]: https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/compare/v3.8.0...v3.9.0
[v3.8.0]: https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/compare/v3.7.0...v3.8.0
[v3.7.0]: https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/compare/v3.6.0...v3.7.0
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
