data "azurerm_resource_group" "rg" {
  name = local.resource_group_name
}

data "azurerm_virtual_network" "vnet" {
    name = local.vnet_name
    resource_group_name = local.resource_group_name
}

data "azurerm_network_interface" "web_linuxvm_nic" {
    count = var.web_linuxvm_instance_count
    name = "${local.resource_name_prefix}-web-linuxvm-nic-${count.index}"
    resource_group_name = local.resource_group_name
}
