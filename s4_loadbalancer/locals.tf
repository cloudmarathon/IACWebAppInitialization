# Define Local Values in Terraform
locals {
  owners = var.business_divsion
  environment = var.environment
  resource_name_prefix = "${var.business_divsion}-${var.environment}"
  common_tags = {
    owners = local.owners
    environment = local.environment
  }
  resource_group_name = "rg-web-app-eastus"
   vnet_name = "webapp-dev-vnet"
  web_linuxvm_nic_name = "webapp-dev-web-linuxvm"

} 