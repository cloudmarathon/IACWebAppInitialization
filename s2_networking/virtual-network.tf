# Create Virtual Network
data "azurerm_resource_group" "rg" {
  name = "rg-hr-dev-tqrpzb"
}

resource "azurerm_virtual_network" "vnet" {
  name                = "${local.resource_name_prefix}-${var.vnet_name}"
  address_space       = var.vnet_address_space
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
  tags = local.common_tags
}
