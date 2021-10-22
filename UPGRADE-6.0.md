# Upgrade from v5.x to v6.x

If you have any questions regarding this upgrade process, please consult the `examples` directory:

- [Autoscaling](examples/autoscaling): A PostgreSQL cluster with enhanced monitoring and autoscaling enabled
- [Global Cluster](examples/global_cluster): A PostgreSQL global cluster with clusters provisioned in two different region
- [MySQL](examples/mysql): A simple MySQL cluster
- [PostgreSQL](examples/postgresql): A simple PostgreSQL cluster
- [S3 Import](examples/s3_import): A MySQL cluster created from a Percona Xtrabackup stored in S3
- [Serverless](examples/serverless): Serverless PostgreSQL and MySQL clusters

If you find a bug, please open an issue with supporting configuration to reproduce.

## List of backwards incompatible changes

- TODO

### Variable and output changes

1. Removed variables:

   - `todo`

2. Renamed variables:

   - `todo` -> `todo`

3. Removed outputs:

   - `todo`

4. Renamed outputs:

- `todo`

## Upgrade State Migrations

### Before 5.x Example

```hcl
module "cluster_before" {
  source  = "terraform-aws-modules/rds-aurora/aws"
  version = "~> 5.0"

  # TODO

  tags = local.tags
}
```

### After 6.x Example

```hcl
module "cluster_after" {
  source  = "terraform-aws-modules/rds-aurora/aws"
  version = "~> 6.0"

  # TODO

  tags = local.tags
}
```

To migrate from the `v5.x` version to `v6.x` version example shown above, the following state move commands can be performed to maintain the current resources without modification:

```bash
terraform state mv 'module.cluster_before.todo[0]' 'module.cluster_after.todo.this[0]'
```

:info: Notes

- TODO
