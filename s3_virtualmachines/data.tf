# All data blocks in this folder
data "azurerm_subscription" "primary" {
}

data "azurerm_client_config" "current" {
}

data "azurerm_resource_group" "rg" {
    name = local.resource_group_name
}

data "azurerm_virtual_network" "vnet" {
    name = local.vnet_name
    resource_group_name =  local.resource_group_name
}

data "azurerm_subnet" "websubnet" {
    name = local.webapp_subnet_name
    resource_group_name =  local.resource_group_name
    virtual_network_name = local.vnet_name
}

data "azurerm_subnet" "bastionsubnet"{
    name = local.bastion_subnet_name
    resource_group_name =  local.resource_group_name
    virtual_network_name = local.vnet_name
}
