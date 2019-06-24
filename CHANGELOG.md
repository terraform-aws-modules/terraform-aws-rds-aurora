<a name="unreleased"></a>
## [Unreleased]



<a name="v2.2.0"></a>
## [v2.2.0] - 2019-06-24

- Support using previously created SG for Aurora cluster - TF 0.12 ([#49](https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/issues/49))
- Updated CHANGELOG
- Add cluster ARN output as 'this_rds_cluster_arn' ([#48](https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/issues/48))
- Updated CHANGELOG
- Upgraded module to support Terraform 0.12 ([#45](https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/issues/45))


<a name="v1.15.0"></a>
## [v1.15.0] - 2019-06-24

- Allow the addition of IP-based ingress rules ([#51](https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/issues/51))
- vpc_security_group_ids for Terraform 0.11 ([#46](https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/issues/46))


<a name="v2.1.0"></a>
## [v2.1.0] - 2019-06-14

- Updated CHANGELOG
- Add cluster ARN output as 'this_rds_cluster_arn' ([#48](https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/issues/48))
- Updated CHANGELOG
- Upgraded module to support Terraform 0.12 ([#45](https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/issues/45))


<a name="v1.14.0"></a>
## [v1.14.0] - 2019-06-13

- vpc_security_group_ids for Terraform 0.11 ([#46](https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/issues/46))


<a name="v2.0.0"></a>
## [v2.0.0] - 2019-06-11

- Updated CHANGELOG
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


[Unreleased]: https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/compare/v2.2.0...HEAD
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
