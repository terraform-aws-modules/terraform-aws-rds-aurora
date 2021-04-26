# MySQL S3 Import Example

Configuration in this directory creates set of RDS resources including DB instance, DB subnet group and DB parameter group where the database itself is imported from a MySQL Percona Xtrabackup stored in S3.

## Usage

To run this example you need to execute:

```bash
$ terraform init
$ terraform plan
$ terraform apply
```

## Testing

In order to test this example, you will need a database backup in order to upload to S3 and import into the module. A backup has been provided under `backup/`, but in the case that a new backup needs to be created, the steps outlined below should suffice for creating a backup that can be used for the sake of testing and verifying module functionality/changes.

1. Create database container

```bash
$ docker run -d --name percona-server-mysql-5.7.12 -e MYSQL_ROOT_PASSWORD=root percona/percona-server:5.7.12
$ docker exec -it percona-server-mysql-5.7.12 bash
$ mysql -u root -p # password is also root
```

2. Once logged into container and database, create database and user used by RDS

```sql
CREATE DATABASE s3Import;
CREATE USER 's3_import_user'@'localhost' IDENTIFIED BY 'YourPwdShouldBeLongAndSecure!';
GRANT ALL PRIVILEGES ON * . * TO 's3_import_user'@'localhost';
FLUSH PRIVILEGES;
```

3. Use Percona Xtrabackup container to dump database and upload to S3

```bash
$ mkdir -p /tmp/backup
$ docker run --name percona-xtrabackup-2.4 --mount type=bind,src=/tmp/backup,dst=/backup --volumes-from percona-server-mysql-5.7.12 percona/percona-xtrabackup:2.4 xtrabackup --backup --data-dir=/var/lib/mysql --target-dir=/backup --user=root --password=root
$ mv /tmp/backup ./backup
```

Note that this example may create resources which cost money. Run `terraform destroy` when you don't need these resources.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 3.8 |
| <a name="requirement_random"></a> [random](#requirement\_random) | >= 2.2 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 3.8 |
| <a name="provider_random"></a> [random](#provider\_random) | >= 2.2 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_aurora"></a> [aurora](#module\_aurora) | ../../ |  |
| <a name="module_import_s3_bucket"></a> [import\_s3\_bucket](#module\_import\_s3\_bucket) | terraform-aws-modules/s3-bucket/aws | ~> 2.0 |
| <a name="module_vpc"></a> [vpc](#module\_vpc) | terraform-aws-modules/vpc/aws | ~> 3.0 |

## Resources

| Name | Type |
|------|------|
| [aws_db_parameter_group.example](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_parameter_group) | resource |
| [aws_iam_role.s3_import](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy.s3_import](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_rds_cluster_parameter_group.example](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/rds_cluster_parameter_group) | resource |
| [random_password.master](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [random_pet.this](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/pet) | resource |
| [aws_iam_policy_document.s3_import](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.s3_import_assume](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

No inputs.

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_rds_cluster_database_name"></a> [rds\_cluster\_database\_name](#output\_rds\_cluster\_database\_name) | Name for an automatically created database on cluster creation |
| <a name="output_rds_cluster_endpoint"></a> [rds\_cluster\_endpoint](#output\_rds\_cluster\_endpoint) | The cluster endpoint |
| <a name="output_rds_cluster_id"></a> [rds\_cluster\_id](#output\_rds\_cluster\_id) | The ID of the cluster |
| <a name="output_rds_cluster_instance_endpoints"></a> [rds\_cluster\_instance\_endpoints](#output\_rds\_cluster\_instance\_endpoints) | A list of all cluster instance endpoints |
| <a name="output_rds_cluster_instance_ids"></a> [rds\_cluster\_instance\_ids](#output\_rds\_cluster\_instance\_ids) | A list of all cluster instance ids |
| <a name="output_rds_cluster_master_password"></a> [rds\_cluster\_master\_password](#output\_rds\_cluster\_master\_password) | The master password |
| <a name="output_rds_cluster_master_username"></a> [rds\_cluster\_master\_username](#output\_rds\_cluster\_master\_username) | The master username |
| <a name="output_rds_cluster_port"></a> [rds\_cluster\_port](#output\_rds\_cluster\_port) | The port |
| <a name="output_rds_cluster_reader_endpoint"></a> [rds\_cluster\_reader\_endpoint](#output\_rds\_cluster\_reader\_endpoint) | The cluster reader endpoint |
| <a name="output_rds_cluster_resource_id"></a> [rds\_cluster\_resource\_id](#output\_rds\_cluster\_resource\_id) | The Resource ID of the cluster |
| <a name="output_security_group_id"></a> [security\_group\_id](#output\_security\_group\_id) | The security group ID of the cluster |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
