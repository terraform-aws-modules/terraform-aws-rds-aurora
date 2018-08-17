resource "aws_security_group" "default" {
  name        = "aurora-${var.name}"
  description = "For Aurora cluster ${var.name}"
  vpc_id      = "${var.vpc_id}"
  tags        = "${merge(var.tags, map("Name", "aurora-${var.name}"))}"
}

resource "aws_security_group_rule" "default_ingress" {
  count                    = "${length(var.allowed_security_groups)}"
  type                     = "ingress"
  from_port                = "${aws_rds_cluster.default.port}"
  to_port                  = "${aws_rds_cluster.default.port}"
  protocol                 = "tcp"
  source_security_group_id = "${element(var.allowed_security_groups, count.index)}"
  security_group_id        = "${aws_security_group.default.id}"
}
