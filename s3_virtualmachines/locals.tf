# Define Local Values in Terraform
locals {
  owners = var.business_divsion
  environment = var.environment
  resource_name_prefix = "${var.business_divsion}-${var.environment}" # webapp-dev
  common_tags = {
    owners = local.owners
    environment = local.environment
  }
  resource_group_name = "rg-web-app-eastus"
  vnet_name = "webapp-dev-vnet"
  webapp_subnet_name = "webapp-dev-vnet-websubnet"
  bastion_subnet_name = "webapp-dev-vnet-bastionsubnet"
  
} 