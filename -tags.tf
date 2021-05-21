locals {
  common_tags = merge(var.tags, {
    "ModuleSourceRepo" = "github.com/StratusGrid/terraform-aws-rds-aurora
  })
}
