# Upgrade from v9.x to v10.x

If you have any questions regarding this upgrade process, please consult the `examples` directory.
If you find a bug, please open an issue with supporting configuration to reproduce.

## List of backwards incompatible changes

- Terraform `v1.11` is now minimum supported version to support write-only (`wo_*`) attributes.
- AWS provider `v6.18` is now minimum supported version
- The underlying `aws_security_group_rule` resources has been replaced with `aws_vpc_security_group_ingress_rule` and `aws_vpc_security_group_egress_rule` to allow for more flexibility in defining security group rules.

## Additional changes

### Added

- Support for `region` argument to specify the AWS region for the resources created if different from the provider region.

### Modified

- Variable definitions now contain detailed object types in place of the previously used `any` type

### Removed

- None

### Variable and output changes

1. Removed variables:

    -

2. Renamed variables:

    -

3. Added variables:

    -

4. Removed outputs:

    -

5. Renamed outputs:

    -

6. Added outputs:

    -

## Upgrade Migrations

### Before 9.x Example

```hcl
module "cluster" {
  source  = "terraform-aws-modules/rds-aurora/aws"
  version = "~> 9.0"

  # Only the affected attributes are shown


  tags = {
    Environment = "dev"
    Terraform   = "true"
  }
}
```

### After 10.x Example

```hcl
module "cluster" {
  source  = "terraform-aws-modules/rds-aurora/aws"
  version = "~> 10.0"

  # Only the affected attributes are shown

  tags = {
    Environment = "dev"
    Terraform   = "true"
  }
}
```

### State Changes
