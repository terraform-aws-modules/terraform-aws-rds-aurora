locals {
  port            = "${var.port == "" ? "${var.engine == "aurora-postgresql" ? "5432" : "3306"}" : var.port}"
  master_password = "${var.password == "" ? random_id.master_password.b64 : var.password}"
}
