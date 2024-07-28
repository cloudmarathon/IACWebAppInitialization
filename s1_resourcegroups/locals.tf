locals {
  owners = var.business_divsion
  environment = var.environment
  resource_name_prefix = "${var.business_divsion}-${var.resource_group_location}" # web-app-east-us
  common_tags = {
    owners = local.owners
    environment = local.environment
  }
} 