# Upgrade from v7.x to v8.x

If you have any questions regarding this upgrade process, please consult the `examples` directory.
If you find a bug, please open an issue with supporting configuration to reproduce.

## List of backwards incompatible changes

- The default value for `create_db_subnet_group` has changed from `true` to `false` - typically, a common/shared DB subnet group is utilized since there are no real tangible benefits to creating a new one for each DB cluster
- `allowed_security_groups`, `allowed_cidr_blocks`, and `security_group_egress_rules` have been removed and replaced with a more generic `security_group_rules` variable which supports both ingress and egress rules to/from all supported resources/destinations (e.g. security groups, CIDR blocks, prefix lists, etc.)
- Minimum supported Terraform version is no 1.0

### Variable and output changes

1. Removed variables:

   - `allowed_security_groups` replaced by `security_group_rules`
   - `allowed_cidr_blocks` replaced by `security_group_rules`
   - `security_group_egress_rules` replaced by `security_group_rules`

2. Renamed variables:

   - None

3. Added variables:

   - `security_group_rules`

4. Removed outputs:

   - None

5. Renamed outputs:

   - None

6. Added outputs:

   - None

## Upgrade Migrations

### Before 7.x Example

```hcl
module "cluster_before" {
  source  = "terraform-aws-modules/rds-aurora/aws"
  version = "~> 7.0"

  # Only the affected attributes are shown

  create_db_subnet_group = false
  db_subnet_group_name   = module.vpc.database_subnet_group_name

  create_security_group   = true
  allowed_security_groups = ["sg-12345678"]
  allowed_cidr_blocks     = ["10.20.0.0/20"]

  tags = {
    Environment = "dev"
    Terraform   = "true"
  }
}
```

### After 8.x Example

```hcl
module "cluster_after" {
  source  = "terraform-aws-modules/rds-aurora/aws"
  version = "~> 8.0"

  # Only the affected attributes are shown

  db_subnet_group_name = module.vpc.database_subnet_group_name

  security_group_rules = {
    cidr_ingress_ex = {
      cidr_blocks = ["10.20.0.0/20"]
    }
    security_group_ingress_ex = {
      source_security_group_id = "sg-12345678"
    }
  }

  tags = {
    Environment = "dev"
    Terraform   = "true"
  }
}
```

### State Changes

- None

#### Security Group Rule(s) Migration

To upgrade to v8.x, you will need to migrate your security group rules to the new `security_group_rules` variable and data structure. There are three potential avenues to accomplish this:

1. Perform Terraform state moves `terraform state mv ...`. This has the downside of requiring manual intervention via the Terraform CLI but is still one possiblity.
2. Applying the changes as they are which will result in the old security group ruls being removed and the new rules being added. This has the downside of causing a brief interruption in service which may or may not be tolerable; this is left up to users to decided.
3. In addition to option 2, users can create a new, temporary security group that contains all of the same network access (or more) as the current v6.x security group. Before upgrading your cluster, add this security group to the cluster via the `vpc_security_group_ids` argument which "shadows" the same level of network access while upgrading. Once this security group has been added, you can now safely upgrade from v7.x to v8.x without any network disruption. Once the upgrade is complete, you can remove the temporary security group from the cluster and delete.
