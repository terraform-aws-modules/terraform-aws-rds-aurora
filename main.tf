/**
# terraform-aws-rds-aurora

Creates a AWS Aurora RDS cluster, cluster instances and DB subnet group.

Optional Aurora features can also be enabled:

- Autoscaling of replicas
- Enhanced Monitoring

### Usage

```hcl
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
*   db_parameter_group_name         = "${aws_db_parameter_group.aurora_db_postgres96_parameter_group.id}"
*   db_cluster_parameter_group_name = "${aws_rds_cluster_parameter_group.aurora_cluster_postgres96_parameter_group.id}"
*   tags                            = {
*     "environment" = "dev"
*     "terraform"   = "true"
*   }
* }
```

### Full examples

- [PostgreSQL](examples/postgres): A simple example with VPC and PostgreSQL cluster.
- [MySQL](examples/mysql): A simple example with VPC and MySQL cluster.
- [Advanced](examples/advanced): A PostgreSQL cluster with enhanced monitoring and autoscaling enabled.

## Documentation generation

Documentation should be modified within `main.tf` and generated using [terraform-docs](https://github.com/segmentio/terraform-docs):

```bash
terraform-docs md ./ | cat -s | tail -r | tail -n +2 | tail -r > README.md
```

## License

MIT Licensed. See [LICENSE](https://github.com/deliveryhero/tf-ssh-bastion/tree/master/LICENSE) for full details.
*/
