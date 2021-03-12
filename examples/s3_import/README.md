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
| terraform | >= 0.12.26 |
| aws | >= 3.8 |
| random | >= 2.2 |

## Providers

| Name | Version |
|------|---------|
| aws | >= 3.8 |
| random | >= 2.2 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| aurora | ../../ |  |
| import_s3_bucket | terraform-aws-modules/s3-bucket/aws | ~> 1 |
| vpc | terraform-aws-modules/vpc/aws | ~> 2 |

## Resources

| Name |
|------|
| [aws_db_parameter_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_parameter_group) |
| [aws_iam_policy_document](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) |
| [aws_iam_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) |
| [aws_iam_role_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) |
| [aws_rds_cluster_parameter_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/rds_cluster_parameter_group) |
| [random_password](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) |
| [random_pet](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/pet) |

## Inputs

No input.

## Outputs

| Name | Description |
|------|-------------|
| this\_rds\_cluster\_database\_name | Name for an automatically created database on cluster creation |
| this\_rds\_cluster\_endpoint | The cluster endpoint |
| this\_rds\_cluster\_id | The ID of the cluster |
| this\_rds\_cluster\_instance\_endpoints | A list of all cluster instance endpoints |
| this\_rds\_cluster\_instance\_ids | A list of all cluster instance ids |
| this\_rds\_cluster\_master\_password | The master password |
| this\_rds\_cluster\_master\_username | The master username |
| this\_rds\_cluster\_port | The port |
| this\_rds\_cluster\_reader\_endpoint | The cluster reader endpoint |
| this\_rds\_cluster\_resource\_id | The Resource ID of the cluster |
| this\_security\_group\_id | The security group ID of the cluster |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
