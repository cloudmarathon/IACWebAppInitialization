data "azurerm_resource_group" "rg" {
  name = local.resource_group_name
}

data "azurerm_virtual_network" "vnet" {
    name = local.vnet_name
    resource_group_name = local.resource_group_name
}

data "azurerm_network_interface" "web_linuxvm_nic" {
    name = local.web_linuxvm_nic_name
    resource_group_name = local.resource_group_name
}
